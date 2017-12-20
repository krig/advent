use "buffered"
use "collections"
use "files"

interface Summer
  fun ref apply(input: String): ISize

class NumSum
  new create() =>
    None
  fun ref apply(input: String): ISize =>
    try
      var sum: ISize = 0
      let limit = input.size()
      for idx in Range(0, limit) do
        let cmp = if idx == (limit - 1) then 0 else idx + 1 end
        if input(idx)? == input(cmp)? then
          let i = idx.isize()
          let num = input.substring(i, i + 1).isize()?
          sum = sum + num
        end
      end
      sum
    else
      -1
    end

class NumSum2
  new create() =>
    None
  fun ref apply(input: String): ISize =>
    try
      var sum: ISize = 0
      let limit = input.size()
      let half = limit / 2
      for idx in Range(0, limit) do
        let cmp = if (idx + half) >= limit then (idx + half) - limit else (idx + half) end
        if input(idx)? == input(cmp)? then
          let i = idx.isize()
          let num = input.substring(i, i + 1).isize()?
          sum = sum + num
        end
      end
      sum
    else
      -1
    end

class Notifier is StdinNotify
  let _env: Env
  let _consumer: Summer ref
  new create(env: Env, consumer: Summer) =>
    _env = env
    _consumer = consumer

  fun ref apply(data: Array[U8] iso) =>
    let input: String iso = String.from_iso_array(consume data)
    input.strip()
    _env.out.print(_consumer(consume input).string())

actor Main
  new create(env: Env) =>
    if env.args.contains("test", {(l, r): Bool => l == r}) then
      let args: Array[String] val = recover env.args.slice(1) end
      MainTest(recover Env.create(env.root, env.input, env.out, env.err, args, env.vars()) end)
    elseif env.args.contains("part2", {(l, r): Bool => l == r}) then
      env.input(recover Notifier(env, NumSum2.create()) end, 2048)
    else
      env.input(recover Notifier(env, NumSum.create()) end, 2048)
    end
