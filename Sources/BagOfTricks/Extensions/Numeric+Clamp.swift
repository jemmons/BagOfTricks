import Foundation



public extension FloatingPoint {
  func clamp(to range: ClosedRange<Self>) -> Self {
    return Swift.max(range.lowerBound, Swift.min(range.upperBound, self))
  }
}



public extension BinaryInteger {
  func clamp(to range: ClosedRange<Self>) -> Self {
    return Swift.max(range.lowerBound, Swift.min(range.upperBound, self))
  }
}
