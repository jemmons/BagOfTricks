import Foundation



public struct Count {
  private let value: Int
  
  
  public init(_ value: Int) {
    self.value = value
  }
  
  
  public var index: Int {
    get {
      value - 1
    }
  }
  
  
  public var count: Int {
    get {
      value
    }
  }
}
