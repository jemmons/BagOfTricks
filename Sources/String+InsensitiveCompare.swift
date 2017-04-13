import Foundation

infix operator ==* : ComparisonPrecedence


/// This will compare two strings insensitively on the basis of the current locale. For example, this operator would return true when evaluating any combination of the following: `foo`, `Foo`, `föö`, `fｏｏ`.
public func ==*(lhs: String?, rhs: String?) -> Bool {
  switch (lhs, rhs) {
  case (nil, nil):
    return true
  case let (x?, y?):
    return x.compare(y, options: [.caseInsensitive, .diacriticInsensitive, .widthInsensitive], range: nil, locale: Locale.current) == .orderedSame
  default:
    return false
  }
}
