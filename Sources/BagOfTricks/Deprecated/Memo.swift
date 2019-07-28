import Foundation



@available(swift, deprecated: 5.1, message: "Better implemented as a property wrapper")
public class Memo<T> {
  private var maybe: MaybeMemo<T>
  
  public init(factory: @escaping ()->T) {
    maybe = MaybeMemo<T>(factory: factory)
  }
}



public extension Memo {
  func value() -> T {
    guard let value = maybe.value() else {
      fatalError("Memo's non-optional factory somehow produced an optional.")
    }
    return value
  }
  
  
  func invalidate() {
    maybe.invalidate()
  }
}
