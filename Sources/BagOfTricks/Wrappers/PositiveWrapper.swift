import Foundation



@propertyWrapper
public struct Positive<Value> where Value: Numeric, Value: Comparable {
  private var value: Clamp<Value>
  
  
  public init(wrappedValue: Value) {
    value = Clamp(wrappedValue: wrappedValue, range: (Value.zero...))
  }

  
  public init(wrappedValue: Value, through: Value) {
    value = Clamp(wrappedValue: wrappedValue, range: (Value.zero...through))
  }

  
  public var wrappedValue: Value {
    get {
      return value.wrappedValue
    }
    
    set {
      value.wrappedValue = newValue
    }
  }
}

