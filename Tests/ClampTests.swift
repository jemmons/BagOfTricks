import Foundation
import XCTest
import BagOfTricks



class ClampTests: XCTestCase {
  func testInt() {
    let range = 5...10 as ClosedRange
    let tooHigh = 11
    let tooLow = 4
    let justRight = 7
    let lowerBound = 5
    let upperBound = 10
    XCTAssertEqual(tooHigh.clamp(to: range), range.upperBound)
    XCTAssertEqual(tooLow.clamp(to: range), range.lowerBound)
    XCTAssertEqual(justRight.clamp(to: range), justRight)
    XCTAssertEqual(lowerBound.clamp(to: range), lowerBound)
    XCTAssertEqual(upperBound.clamp(to: range), upperBound)
  }
  
  
  func testFloat() {
    let range = 5.5...10.5 as ClosedRange
    let tooHigh = 11.5
    let tooLow = 4.5
    let justRight = 7.5
    let lowerBound = 5.5
    let upperBound = 10.5
    XCTAssertEqual(tooHigh.clamp(to: range), range.upperBound)
    XCTAssertEqual(tooLow.clamp(to: range), range.lowerBound)
    XCTAssertEqual(justRight.clamp(to: range), justRight)
    XCTAssertEqual(lowerBound.clamp(to: range), lowerBound)
    XCTAssertEqual(upperBound.clamp(to: range), upperBound)
  }
}
