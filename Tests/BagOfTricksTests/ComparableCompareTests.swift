import XCTest
import BagOfTricks



class ComparableCompareTests: XCTestCase {
  func testEquality() {
    switch 10.1.compare(10.1) {
    case .equal:
      XCTAssert(true)
    default:
      XCTFail()
    }
  }


  func testLessThan() {
    switch 10.1.compare(44.1) {
    case .lessThan:
      XCTAssert(true)
    default:
      XCTFail()
    }
  }


  func testGreaterThan() {
    switch 10.1.compare(2.2) {
    case .greaterThan:
      XCTAssert(true)
    default:
      XCTFail()
    }
  }
}
