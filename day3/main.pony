use "collections"

actor Main
  new create(env: Env) =>
    let square = try
      env.args(2)?.usize()?
    else
      env.err.print("Unexpected second argument. Usage: part1|part2 <square>.")
      env.exitcode(1)
      return
    end

    try
      match env.args(1)?
      | "part1" =>
        Part1(env, square)
      | "part2" =>
        Part2(env, square)
      end
    else
      env.err.print("Unexpected first argument. Usage: part1|part2 <square>.")
      env.exitcode(1)
      return
    end


primitive Part1

  fun fieldside(target: USize): USize =>
    var ret: USize = 1
    while (ret * ret) < target do
      ret = ret + 2
    end
    ret

  fun minsteps(target: USize, side: USize): USize =>
    if target == 1 then
      0
    elseif target < 10 then
      if (target == 3) or (target == 5) or (target == 7) or (target == 9) then
        2
      else
        1
      end
    else
      side / 2
    end

  fun offset(target: USize, side: USize): USize =>
    let base = ((side - 2) * (side - 2))
    let maxoffs = (side / 2)
    var offs: ISize = maxoffs.isize() - 1
    var dir: ISize = -1
    var curr: ISize = base.isize() + 1
    while curr != target.isize() do
      offs = offs + dir
      if offs == 0 then
        dir = 1
      elseif offs == maxoffs.isize() then
        dir = -1
      end
      curr = curr + 1
    end
    offs.usize()

  fun apply(env: Env, target: USize) =>
    let side = fieldside(target)
    let nsteps = if target < 10 then
      minsteps(target, side)
    else
      minsteps(target, side) + offset(target, side)
    end
    env.out.print(nsteps.string())


primitive Part2
  fun apply(env: Env, target: USize) =>
    let nsteps = 0
    env.out.print(nsteps.string())
