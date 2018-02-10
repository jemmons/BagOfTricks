import Foundation



public class BindIfReady<T, U> {
  private let binding: (T, U)->Void
  
  
  public var object: T? {
    didSet {
      bind()
    }
  }
  
  
  public var value: U? {
    didSet {
      bind()
    }
  }
  
  
  public init(binding: @escaping (T, U)->Void) {
    self.binding = binding
  }
  
  
  private func bind() {
    if
      let someObject = object,
      let someValue = value {
      binding(someObject, someValue)
    }
  }
}



public class FillIfReady<T>: BindIfReady<T, T.Value> where T: Fillable {
  public init() {
    super.init { (obj, val) in
      obj.fill(with: val)
    }
  }
}

