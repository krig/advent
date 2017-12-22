class MinMax
  let min: ISize
  let max: ISize

  new create(mini: ISize, maxi: ISize) =>
    min = mini
    max = maxi

  new from_array(arr: Array[ISize] box) =>
    var cmin = ISize.max_value()
    var cmax = ISize.min_value()
    for v in arr.values() do
      if cmin > v then
        cmin = v
      end
      if cmax < v then
        cmax = v
      end
    end
    min = cmin
    max = cmax

  fun eq(o: MinMax box): Bool =>
    (min == o.min) and (max == o.max)

  fun ne(o: MinMax box): Bool =>
    (min != o.min) or (max != o.max)

  fun string(): String iso^ =>
    let s: String iso = min.string().clone()
    s.append("/")
    s.append(max.string())
    s
