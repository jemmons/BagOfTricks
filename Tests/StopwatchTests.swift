import XCTest
import BagOfTricks



class StopwatchTests: XCTestCase {
  func testFirstDoNoHarm() {
    TICK()
    XCTAssert(true)
    TOCK()
  }
}
