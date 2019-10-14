import Foundation



@propertyWrapper
public struct Forgetful<Value> {
  private var value: Value?
  private let factory: () -> Value
  
  
  public var wrappedValue: Value {
    mutating get {
      guard let someValue = value else {
        return given(factory()) {
          value = $0
        }
      }
      return someValue
    }
  }

  
  public init(wrappedValue: @autoclosure @escaping () -> Value) {
    factory = wrappedValue
  }
  
  
  public mutating func forget() {
    value = nil
  }
  
  
  public var projectedValue: Self {
    get { return self }
    set { self = newValue }
  }
}
