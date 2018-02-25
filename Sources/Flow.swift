import Foundation



public func given<T>(_ object:T, with: (_:T)->Void)->T{
  with(object)
  return object
}


public func with<T>(_ object: T, perform: (_:T)->Void) {
  perform(object)
}


public func with<T, U>(_ first: T, _ second: U, perform: (_:T, _:U)->Void) {
  perform(first, second)
}


public func with<T, U, V>(_ first: T, _ second: U, _ third: V, perform: (_:T, _:U, _:V)->Void) {
  perform(first, second, third)
}


public func with<T, U, V, W>(_ first: T, _ second: U, _ third: V, _ fourth: W, perform: (_:T, _:U, _:V, _:W)->Void) {
  perform(first, second, third, fourth)
}

