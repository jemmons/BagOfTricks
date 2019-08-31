import Foundation



public enum ComparisonValue {
  case lessThan, greaterThan, equal
}



public extension Comparable {
  func compare(_ to: Self) -> ComparisonValue {
    guard self != to else {
      return .equal
    }
    if self > to {
      return .greaterThan
    } else {
      return .lessThan
    }
  }
}
