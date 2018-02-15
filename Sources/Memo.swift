import Foundation



public struct Memo<T> {
  private var maybe: MaybeMemo<T>
  
  public init(factory: @escaping ()->T) {
    maybe = MaybeMemo<T>(factory: factory)
  }
}



public extension Memo {
  mutating func value() -> T {
    guard let value = maybe.value() else {
      fatalError("Memo's non-optional factory somehow produced an optional.")
    }
    return value
  }
  
  
  mutating func invalidate() {
    maybe.invalidate()
  }
}
