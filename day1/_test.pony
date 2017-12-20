use "ponytest"

actor MainTest is TestList
    new create(env: Env) => PonyTest(env, this)
    new make() => None

    fun tag tests(test: PonyTest) =>
        test(_Test1122)
        test(_Test1111)
        test(_Test1234)
        test(_Test91212129)

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
