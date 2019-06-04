import Foundation
import XCTest
import BagOfTricks



class OptionalAssumptionsTests: XCTestCase {
  let maybeFalse: Bool? = false
  let maybeTrue: Bool? = true
  let maybeNil: Bool? = nil
  
  func testAssumingTrue() {
    XCTAssert(maybeTrue.assumingTrue)
    XCTAssertFalse(maybeFalse.assumingTrue)
    XCTAssert(maybeNil.assumingTrue)
  }
  
  func testAssumingFalse() {
    XCTAssert(maybeTrue.assumingFalse)
    XCTAssertFalse(maybeFalse.assumingFalse)
    XCTAssertFalse(maybeNil.assumingFalse)
  }
}
