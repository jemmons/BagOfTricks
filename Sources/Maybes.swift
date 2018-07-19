import Foundation



public extension URL {
  @available(*, deprecated, message: "Use `flatMap` instead. See: http://www.figure.ink/blog/2018/3/29/optionals-as-collections" )
  init?(maybeString: String?) {
    guard let string = maybeString else {
      return nil
    }
    self.init(string: string)
  }
}
