import Foundation


public extension Numeric where Self: Comparable {
  func clamp(to range: ClosedRange<Self>) -> Self {
    return max(range.lowerBound, min(range.upperBound, self))
  }
  
  
  func clamp(to range: PartialRangeFrom<Self>) -> Self {
    return max(range.lowerBound, self)
  }

  
  func clamp(to range: PartialRangeThrough<Self>) -> Self {
    return min(range.upperBound, self)
  }
}
