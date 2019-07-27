import Foundation



private var formatter = given(NumberFormatter()) {
  $0.numberStyle = .percent
  $0.minimumFractionDigits = 0
  $0.maximumFractionDigits = 2
}



public struct ProperFraction {
  public let value: Double
  
  
  public init(_ fraction: Double) throws {
    guard fraction >= 0.0, fraction <= 1.0 else {
      throw Error.outOfRange(fraction)
    }
    value = fraction
  }
  
  
  public init(clipping fraction: Double) {
    try! self.init(fraction.clamp(to: 0...1))
  }
}



public extension ProperFraction {
  enum Error: LocalizedError {
    case outOfRange(Double)
 
    public var errorDescription: String? {
      switch self {
      case .outOfRange(let d):
        return "The value \(d) is not between 0.0 and 1.0."
      }
    }
  }
}



extension ProperFraction: CustomStringConvertible {
  public var description: String {
    return formatter.string(from: NSNumber(value: value)) ?? "Unknown"
  }
}
