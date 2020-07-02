import Foundation



public class WeakBindIfReady<Object, Value> where Object: AnyObject {
  private let binding: (Object, Value)->Void
  
  
  weak public var object: Object? {
    didSet {
      bind()
    }
  }
  
  
  public var value: Value? {
    didSet {
      bind()
    }
  }
  
  
  public init(binding: @escaping (Object, Value)->Void) {
    self.binding = binding
  }
  
  
  private func bind() {
    if
      let someObject = object,
      let someValue = value {
      binding(someObject, someValue)
      value = nil
    }
  }
}



public class BindIfReady<Object, Value>: WeakBindIfReady<Object, Value> where Object: AnyObject {
  private var _strongObject: Object?
  
  
  override public var object: Object? {
    didSet {
      _strongObject = object
    }
  }
}



public class FillIfReady<FillableObject>: BindIfReady<FillableObject, FillableObject.Value> where FillableObject: Fillable & AnyObject {
  public init() {
    super.init { obj, val in
      obj.fill(with: val)
    }
  }
}



public class WeakFillIfReady<FillableObject>: WeakBindIfReady<FillableObject, FillableObject.Value> where FillableObject: Fillable & AnyObject {
  public init() {
    super.init { obj, val in
      obj.fill(with: val)
    }
  }
}
