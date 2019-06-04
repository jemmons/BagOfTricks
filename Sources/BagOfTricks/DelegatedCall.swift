import Foundation


/**
 Stolen from [this article][1] by [Oleg Dreyman][2].
 
 [1]: https://medium.com/anysuggestion/preventing-memory-leaks-with-swift-compile-time-safety-49b845df4dc6
 [2]: https://twitter.com/olegdreyman
 */
public struct DelegatedCall<T> {
  public private(set) var perform: ((T) -> Void)?
  
  
  public init() {}
}



public extension DelegatedCall {
  mutating func delegate<Context>(to context: Context, with f: @escaping (Context, T) -> Void) where Context: AnyObject {
    self.perform = { [weak context] value in
      guard let someContext = context else {
        return
      }
      f(someContext, value)
    }
  }
}
