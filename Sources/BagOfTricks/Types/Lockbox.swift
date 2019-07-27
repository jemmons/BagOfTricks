import Foundation



public class Lockbox<T> {
  private let keep: T
  public init(keep: T) {
    self.keep = keep
  }
}
