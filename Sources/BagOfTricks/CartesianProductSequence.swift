import Foundation



public struct CartesianProductIterator<X, Y>: IteratorProtocol where X: IteratorProtocol, Y: Collection {
  private var xIt: X
  private var x: X.Element?
  private let yCol: Y
  private var yIt: Y.Iterator
  
  public typealias Element = (X.Element, Y.Element)
  
  /**
   Initializes the iterator. To calculate the product of two sets, one must be iterated over once, while the other must be iterated over multiple times. Thus we require one iterator and one colleciton.
   */
  public init(xs: X, ys: Y) {
    xIt = xs
    yCol = ys
    
    x = xIt.next()
    yIt = yCol.makeIterator()
  }
  
  
  public mutating func next() -> Element? {
    //We short circuit this becasue otherwise we'd have to grow the stack to the size of `xIt` before we find out there's no `next`.
    guard !yCol.isEmpty else {
      return nil
    }
    
    guard let someX = x else {
      return nil
    }
    
    guard let someY = yIt.next() else {
      yIt = yCol.makeIterator()
      x = xIt.next()
      return next()
    }
    
    return (someX, someY)
  }
}



public struct CartesianProductSequence<X, Y>: Sequence where X: Sequence, Y: Collection {
  public typealias Iterator = CartesianProductIterator<X.Iterator, Y>
  
  private let xs: X
  private let ys: Y
  
  public init(xs: X, ys: Y) {
    self.xs = xs
    self.ys = ys
  }
  
  public func makeIterator() -> Iterator {
    return Iterator(xs: xs.makeIterator(), ys: ys)
  }
}



public func product<X, Y>(_ xs: X, _ ys: Y) -> CartesianProductSequence<X, Y> where X: Sequence, Y: Collection {
  return CartesianProductSequence(xs: xs, ys: ys)
}
