import Foundation
import XCTest
import BagOfTricks



class ClampTests: XCTestCase {
  func testInt() {
    let range = 5...10 as ClosedRange
    let tooHigh = 11
    let tooLow = 4
    let justRight = 7
    XCTAssertEqual(tooHigh.clamp(to: range), range.upperBound)
    XCTAssertEqual(tooLow.clamp(to: range), range.lowerBound)
    XCTAssertEqual(justRight.clamp(to: range), justRight)
  }
  
  
  func testFloat() {
    let range = 5.5...10.5 as ClosedRange
    let tooHigh = 11.5
    let tooLow = 4.5
    let justRight = 7.5
    XCTAssertEqual(tooHigh.clamp(to: range), range.upperBound)
    XCTAssertEqual(tooLow.clamp(to: range), range.lowerBound)
    XCTAssertEqual(justRight.clamp(to: range), justRight)
  }
}
