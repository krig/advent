use "regex"
use "itertools"

primitive RegexSplit
  """
  Creates a string from an array of bytes
  """

  fun apply(input: String, re: String): Array[String] ? =>
    let r = Regex(re)?
    r.split(input)?
