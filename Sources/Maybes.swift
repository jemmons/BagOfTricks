import Foundation



public extension URL {
  init?(maybeString: String?) {
    guard let string = maybeString else {
      return nil
    }
    self.init(string: string)
  }
}
