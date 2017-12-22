use "buffered"
use "collections"
use "files"
use "itertools"
use "promises"
use "regex"
use "oolong"

interface ISizeReceiver
  fun ref apply(value: ISize)

actor RowChecksum
  let _row: String

  new create(row: String) =>
    _row = row

  be calculate(p: Promise[ISize]) =>
    var diff: ISize = 0
    try
      let sp = RegexSplit(_row, "\\s+")?
      let ip: Array[ISize] = []
      Iter[String](sp.values()).map[ISize]({(x) => try x.isize()? else 0 end }).collect(ip)
      let mm = MinMax.from_array(ip)
      diff = mm.max - mm.min
    else
      diff = 0
    end

    p(recover diff end)

actor Checksum
  let _input: String
  var _reporter: (ISizeReceiver | None)

  new create(input: String) =>
    _input = input
    _reporter = None

  be report(reporter: ISizeReceiver iso) =>
    _reporter = consume reporter
    let create_promise =
      {(row: String): Promise[ISize] =>
        let checksum = RowChecksum(row)
        let p = Promise[ISize]
        checksum.calculate(p)
        p
      } iso
      Promises[ISize].join(
        Iter[String](_input.split("\n").values())
          .map[Promise[ISize]](consume create_promise))
        .next[None](recover this~sum_rows() end)

  be sum_rows(coll: Array[ISize] val) =>
    var sum: ISize = 0
    for v in coll.values() do
      sum = sum + v
    end
    match _reporter
      | let r: ISizeReceiver => r(sum)
    else
      None
    end

actor RowEven
  let _row: String

  new create(row: String) =>
    _row = row

  be calculate(p: Promise[ISize]) =>
    var diff: ISize = 0
    try
      let sp = RegexSplit(_row, "\\s+")?
      let ip: Array[ISize] = []
      Iter[String](sp.values()).map[ISize]({(x) => try x.isize()? else 0 end }).collect(ip)
      for e in ip.values() do
        for c in ip.values() do
          if e == c then
            continue
          end
          if e > c then
            if (e % c) == 0 then
              diff = e / c
            end
          else
            if (c % e) == 0 then
              diff = c / e
            end
          end
        end
      end
    else
      diff = 0
    end

    p(recover diff end)

actor Even
  let _input: String
  var _reporter: (ISizeReceiver | None)

  new create(input: String) =>
    _input = input
    _reporter = None

  fun ref print(value: ISize) =>
    match _reporter
      | let r: ISizeReceiver => r(value)
    else
      None
    end

  be report(reporter: ISizeReceiver iso) =>
    _reporter = consume reporter
    let create_promise =
      {(row: String): Promise[ISize] =>
        let even = RowEven(row)
        let p = Promise[ISize]
        even.calculate(p)
        p
      } iso
      Promises[ISize].join(
        Iter[String](_input.split("\n").values())
          .map[Promise[ISize]](consume create_promise))
        .next[None](recover this~sum_rows() end)

  be sum_rows(coll: Array[ISize] val) =>
    var sum: ISize = 0
    for v in coll.values() do
      //print(v)
      sum = sum + v
    end
    print(sum)

interface Notified
  fun ref apply(env: Env, input: String)

class Notifier is StdinNotify
  let _env: Env
  let _consumer: Notified
  new create(env: Env, consumer: Notified) =>
    _env = env
    _consumer = consumer

  fun ref apply(data: Array[U8] iso) =>
    let input: String iso = String.from_iso_array(consume data)
    input.strip()
    _consumer(_env, consume input)

actor Main
  fun has_arg(env: Env, arg: String val): Bool =>
    try env.args(1)? == arg else false end

  new create(env: Env) =>
    if has_arg(env, "test") then
      let args: Array[String] val = recover env.args.slice(1) end
      MainTest(recover Env.create(env.root, env.input, env.out, env.err, args, env.vars()) end)
    elseif has_arg(env, "even") then
      env.input(recover Notifier(env, {(env, inp) => Even(inp).report({(value) => env.out.print(value.string()) }) }) end, 2048)
    else
      env.input(recover Notifier(env, {(env, inp) => Checksum(inp).report({(value) => env.out.print(value.string()) }) }) end, 2048)
    end
