import Foundation



public class Siphon<T> where T: Fillable {
  public var object: T? {
    didSet {
      doAssignment()
    }
  }
  
  
  public var value: T.Value? {
    didSet {
      doAssignment()
    }
  }
  
  
  public init() {}
  
  
  private func doAssignment() {
    if
      let someObject = object,
      let someValue = value {
      someObject.fill(with: someValue)
    }
  }
}
