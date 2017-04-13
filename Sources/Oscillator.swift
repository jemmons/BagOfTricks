import Foundation



/// An inifinite iterator that bounces back and forth between two given values a defined step at a time.
public struct Oscillator<T>: IteratorProtocol where T: Strideable {
  private let lower: T
  private let upper: T
  private var step: T.Stride
  private var this: T
  
  
  /**
   Initializes an Oscillator that provides values between `lower` and `upper` by `step`.
   
   Starting at `lower`, an oscillator will return values in the range `lower...upper` that differ by `step`. If the step size would cause the next iteration to fall outside `a...b`, the iteration is reveresed and moves `step` in the other direction instead. Thus, depending on `step`, it is possible `upper` will never be included in the iteration:
   
   ```
   var o = Oscillator(lower: 0.0, upper: 1.0, step: 0.5)
   //> [0.0, 0.5, 1.0, 0.5, 0.0, 0.5, ...]
   
   var p = Oscillator(lower: 0.0, upper: 1.0, step: 0.4)
   //> [0.0, 0.4, 0.8, 0.4, 0.0, 0.4, ...]
   ```

   - Warning: The distance between `a` and `b` should be greater than `step`, or `next()` will always return `nil`.
   
   - Parameter lower: The lower bound of values to oscillate between
   
   - Parameter upper: The upper bound of values to oscillate between.
   
   - Parameter step: The amount by which each iteration will differ from the last.
   */
  public init(lower: T, upper: T, step: T.Stride) {
    self.lower = lower
    this = lower
    self.upper = upper
    self.step = step
  }
}



public extension Oscillator {
  /**
   Gets the next value in the range `lower...upper` that differs by `step`. This could be a `step` greater or a `step` less depending on the current phase.
   
   - Returns: A value a `step` greater or `step` lesser than the last call to `next()`. If `step` is greater than the distance between `lower` and `upper` this always returns `nil`.
   */
  mutating func next() -> T? {
    guard lower.distance(to: upper) >= step else {
      return nil
    }
    defer {
      advanceThis()
    }
    return this
  }
}



private extension Oscillator {
  mutating func advanceThis() {
    let next = this.advanced(by: step)
    switch next {
    case (lower...upper):
      this = next
    default:
      step = -step
      advanceThis()
    }
  }
}
