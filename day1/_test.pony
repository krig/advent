use "ponytest"

actor MainTest is TestList
  new create(env: Env) => PonyTest(env, this)
  new make() => None

  fun tag tests(test: PonyTest) =>
    test(_Test1122)
    test(_Test1111)
    test(_Test1234)
    test(_Test91212129)
    test(_Test1212)
    test(_Test1221)
    test(_Test123425)
    test(_Test123123)
    test(_Test12131415)

class iso _Test1122 is UnitTest
  fun name(): String => "1122"
  fun apply(h: TestHelper) =>
    h.assert_eq[ISize](NumSum("1122"), 3)

class iso _Test1111 is UnitTest
  fun name(): String => "1111"
  fun apply(h: TestHelper) =>
    h.assert_eq[ISize](NumSum("1111"), 4)

class iso _Test1234 is UnitTest
  fun name(): String => "1234"
  fun apply(h: TestHelper) =>
    h.assert_eq[ISize](NumSum("1234"), 0)

class iso _Test91212129 is UnitTest
  fun name(): String => "91212129"
  fun apply(h: TestHelper) =>
    h.assert_eq[ISize](NumSum("91212129"), 9)

class iso _Test1212 is UnitTest
  fun name(): String => "1212"
  fun apply(h: TestHelper) =>
    h.assert_eq[ISize](NumSum2("1212"), 6)

class iso _Test1221 is UnitTest
  fun name(): String => "1221"
  fun apply(h: TestHelper) =>
    h.assert_eq[ISize](NumSum2("1221"), 0)

class iso _Test123425 is UnitTest
  fun name(): String => "123425"
  fun apply(h: TestHelper) =>
    h.assert_eq[ISize](NumSum2("123425"), 4)

class iso _Test123123 is UnitTest
  fun name(): String => "123123"
  fun apply(h: TestHelper) =>
    h.assert_eq[ISize](NumSum2("123123"), 12)

class iso _Test12131415 is UnitTest
  fun name(): String => "12131415"
  fun apply(h: TestHelper) =>
    h.assert_eq[ISize](NumSum2("12131415"), 4)
