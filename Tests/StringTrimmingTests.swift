import Foundation
import XCTest
import BagOfTricks

class StringTrimmingTests: XCTestCase {
  func testTrimming() {
    let subject = "  \t \n foo bar\tbaz\nthud \t\t   \n"
    XCTAssertEqual(subject.trimmingWhitespace, "foo bar\tbaz\nthud")
  }
  
  
  func testBlank() {
    var subject = " \t \n "
    XCTAssert(subject.isBlank)
    XCTAssertFalse(subject.isNotBlank)
    
    subject = "foo"
    XCTAssert(subject.isNotBlank)
    XCTAssertFalse(subject.isBlank)
    
    subject = " bar "
    XCTAssert(subject.isNotBlank)
    XCTAssertFalse(subject.isBlank)
    
    subject = "b a z"
    XCTAssert(subject.isNotBlank)
    XCTAssertFalse(subject.isBlank)
  }
  
  
  func testMaybeBlank() {
    var subject = " \t \n "
    XCTAssertNil(subject.maybeBlank)
    subject = "foo"
    XCTAssertEqual(subject.maybeBlank, "foo")
    subject = " bar "
    XCTAssertEqual(subject.maybeBlank, " bar ")
  }
}
