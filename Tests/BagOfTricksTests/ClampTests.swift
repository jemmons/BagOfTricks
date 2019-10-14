import Foundation
import XCTest
import BagOfTricks



class ClampTests: XCTestCase {
  func testInt() {
    let lowerBound = 5
    let upperBound = 10
    let range = lowerBound...upperBound
    let tooHigh = 11
    let tooLow = 4
    let justRight = 7
    XCTAssertEqual(tooHigh.clamp(to: range), range.upperBound)
    XCTAssertEqual(tooLow.clamp(to: range), range.lowerBound)
    XCTAssertEqual(justRight.clamp(to: range), justRight)
    XCTAssertEqual(lowerBound.clamp(to: range), lowerBound)
    XCTAssertEqual(upperBound.clamp(to: range), upperBound)
  }
  
  
  func testPartialFrom() {
    let lowerBound = 5
    let range = lowerBound...
    let tooLow = 4
    let high = 100
    let realHigh = 10_000_000

    XCTAssertEqual(high, high.clamp(to: range))
    XCTAssertEqual(realHigh, realHigh.clamp(to: range))
    XCTAssertEqual(lowerBound, tooLow.clamp(to: range))
  }

  
  func testPartialThrough() {
    let upperBound = 100
    let range = ...upperBound
    let tooHigh = 101
    let low = 10
    let negative = -1_000

    XCTAssertEqual(low, low.clamp(to: range))
    XCTAssertEqual(negative, negative.clamp(to: range))
    XCTAssertEqual(upperBound, tooHigh.clamp(to: range))
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
