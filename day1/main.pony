use "buffered"
use "collections"
use "files"

class Day1 is StdinNotify
    let _env: Env
    new create(env: Env) =>
        _env = env

    fun ref apply(data: Array[U8] iso) =>
        var input: String ref = String.from_iso_array(consume data).clone()
        input.strip()
        try
            var sum: USize = 0
            let limit = input.size()
            for idx in Range(0, limit) do
                let cmp = if idx == (limit - 1) then 0 else idx + 1 end
                if input(idx)? == input(cmp)? then
                    let i = idx.isize()
                    let num = input.substring(i, i + 1).usize()?
                    sum = sum + num
                end
            end
            _env.out.print(sum.string())
        else
            _env.out.print("Unhandled error")
        end

actor Main
    new create(env: Env) =>
        env.input(recover Day1(env) end, 2048)

