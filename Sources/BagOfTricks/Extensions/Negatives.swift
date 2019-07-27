import Foundation



extension Collection {
  public var isNotEmpty: Bool{
    return ❗️isEmpty
  }
  
  
  public func doesNotContain(where predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Bool {
    let success = try contains(where: predicate)
    return ❗️success
  }
}


extension Sequence where Iterator.Element : Equatable {
  public func doesNotContain(_ element: Self.Iterator.Element) -> Bool {
    return ❗️contains(element)
  }
}


extension String{
  public var isNotEmpty:Bool{
    return ❗️isEmpty
  }
  
  
  public func doesNotContain(_ other: String) -> Bool {
    return ❗️self.contains(other)
  }
}
