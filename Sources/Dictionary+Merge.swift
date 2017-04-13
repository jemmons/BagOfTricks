import Foundation


extension Dictionary{
  public func merging(from newDictionary: [Key: Value]) -> [Key: Value] {
    return self.merging(newDictionary) { $1 }
  }
  
  
  mutating public func merge(from newDictionary: [Key: Value]) {
    self.merge(newDictionary){ $1 }
  }

  
  public static func + (lhs:[Key:Value], rhs:[Key:Value]) -> [Key:Value]{
    return lhs.merging(from: rhs)
  }
}




