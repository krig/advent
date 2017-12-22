use "ponytest"
use "regex"
use "itertools"

actor Main is TestList
  new create(env: Env) => PonyTest(env, this)
  new make() => None

  fun tag tests(test: PonyTest) =>
    test(_TestOolongMinMax)
    test(_TestRegexSplit)

class iso _TestOolongMinMax is UnitTest
  """
  Test oolong/MinMax
  """
  fun name(): String => "oolong/MinMax"

  fun apply(h: TestHelper) =>
    let mm = MinMax.from_array([1; 2; 3; 4; 5])
    h.assert_eq[MinMax](MinMax.create(1, 5), mm)

class iso _TestRegexSplit is UnitTest
  """
  Test oolong/RegexSplit
  """
  fun name(): String => "oolong/RegexSplit"

  fun apply(h: TestHelper) =>
    try
      let s = "1 2   3 4    9"
      let sp = RegexSplit(s, "\\s+")?
      h.assert_array_eq[String](sp, ["1"; "2"; "3"; "4"; "9"])

      let ip = Iter[String](sp.values()).map[ISize]({(x) => try x.isize()? else 0 end }).collect(Array[ISize])
      h.assert_array_eq[ISize](ip, [1; 2; 3; 4; 9])
    else
      h.fail()
    end
