use "buffered"
use "collections"
use "files"

primitive NumSum
    fun apply(input: String): ISize =>
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

class Notifier is StdinNotify
    let _env: Env
    new create(env: Env) =>
        _env = env

    fun ref apply(data: Array[U8] iso) =>
        let input: String iso = String.from_iso_array(consume data)
        input.strip()
        _env.out.print(NumSum(consume input).string())

actor Main
    new create(env: Env) =>
        if env.args.contains("test", {(l, r): Bool => l == r}) then
            let args: Array[String] val = recover env.args.slice(1) end
            MainTest(recover Env.create(env.root, env.input, env.out, env.err, args, env.vars()) end)
        else
            env.input(recover Notifier(env) end, 2048)
        end

