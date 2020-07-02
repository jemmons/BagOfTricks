import Foundation



public struct Index {
  private let value: Int
  
  
  public init(_ value: Int) {
    self.value = value
  }

  
  public var index: Int {
    get {
      value
    }
  }
  
  
  public var count: Int {
    get {
      value + 1
    }
  }
}
