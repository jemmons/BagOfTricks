import Foundation



public func given<T>(_ object:T, with: (_:T)->Void)->T{
  with(object)
  return object
}


public func with<T>(_ object: T, block: (_:T)->Void) {
  block(object)
}
