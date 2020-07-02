import XCTest
import BagOfTricks



class CountAndIndexTests: XCTestCase {
  func testIndex() {
    let subject = Index(42)
    XCTAssertEqual(subject.index, 42)
    XCTAssertEqual(subject.count, 43)
  }
  
  
  func testCount() {
    let subject = Count(42)
    XCTAssertEqual(subject.count, 42)
    XCTAssertEqual(subject.index, 41)
  }
}
