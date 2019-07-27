import Foundation



public extension Optional {
  /// Either converts an `Optional` into it’s unwrapped value or throws `error`.
  func unwrapped(or error: Error) throws -> Wrapped {
    guard let some = self else {
      throw error
    }
    return some
  }
}
