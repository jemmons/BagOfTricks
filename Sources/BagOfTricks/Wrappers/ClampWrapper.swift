import Foundation


private enum RangeSum<Bound> where Bound: Comparable {
  case closed(ClosedRange<Bound>), from(PartialRangeFrom<Bound>), through(PartialRangeThrough<Bound>)
}


@propertyWrapper
public struct Clamp<Value> where Value: Numeric, Value: Comparable {
  private var value: Value
  private let range: RangeSum<Value>
  
  
  public init(wrappedValue: Value, range: ClosedRange<Value>) {
    value = wrappedValue
    self.range = .closed(range)
  }

  
  public init(wrappedValue: Value, range: PartialRangeFrom<Value>) {
    value = wrappedValue
    self.range = .from(range)
  }

  
  public init(wrappedValue: Value, range: PartialRangeThrough<Value>) {
    value = wrappedValue
    self.range = .through(range)
  }

  
  public var wrappedValue: Value {
    get {
      switch range {
      case .closed(let r):
        return value.clamp(to: r)
      case .from(let r):
        return value.clamp(to: r)
      case .through(let r):
        return value.clamp(to: r)
      }
    }
    
    set {
      value = newValue
    }
  }
}
