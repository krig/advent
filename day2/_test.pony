use "ponytest"

actor MainTest is TestList
  new create(env: Env) => PonyTest(env, this)
  new make() => None

  fun tag tests(test: PonyTest) =>
    test(_TestChecksum)
    test(_TestEven)


class TestReporter
  let _h: TestHelper
  let _e: ISize

  new iso create(h: TestHelper, e: ISize) =>
    _h = h
    _e = e

  fun ref apply(sum: ISize) =>
    _h.assert_eq[ISize](sum, _e)
    _h.complete(true)

class iso _TestChecksum is UnitTest
  fun name(): String => "Checksum"
  fun apply(h: TestHelper) =>
    let sum = Checksum("5 1 9 5\n7 5 3\n2 4 6 8")
    let reporter = TestReporter(h, 18)
    sum.report(consume reporter)
    h.long_test(2_000_000_000)
  fun timed_out(h: TestHelper) =>
    h.complete(false)

class iso _TestEven is UnitTest
  fun name(): String => "Even"
  fun apply(h: TestHelper) =>
    let sum = Even("5 9 2 8\n9 4 7 3\n3 8 6 5")
    let reporter = TestReporter(h, 9)
    sum.report(consume reporter)
    h.long_test(2_000_000_000)
  fun timed_out(h: TestHelper) =>
    h.complete(false)
