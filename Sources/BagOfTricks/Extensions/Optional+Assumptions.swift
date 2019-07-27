import Foundation


public extension Optional where Wrapped == Bool {
  var assumingFalse: Bool {
    switch self {
    case .some(let some):
      return some
    case .none:
      return false
    }
  }
  
  
  var assumingTrue: Bool {
    switch self {
    case .some(let some):
      return some
    case .none:
      return true
    }
  }
}
