import Foundation



public protocol Fillable {
  associatedtype Value
  func fill(with: Value)
}
