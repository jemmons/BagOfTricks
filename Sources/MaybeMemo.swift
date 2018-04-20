import Foundation



public class MaybeMemo<T> {
  private var state: T? = nil
  private let factory: ()->T?
  
  public init(factory: @escaping ()->T?) {
    self.factory = factory
  }
}


public extension MaybeMemo {
  func value() -> T? {
    switch state {
    case let v?:
      return v
      
    case nil:
      state = factory()
      return state
    }
  }
  
  
  func invalidate() {
    state = nil
  }
}
