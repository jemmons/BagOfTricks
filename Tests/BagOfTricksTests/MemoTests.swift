import XCTest
import BagOfTricks



class MemoTests: XCTestCase {
  func testSingleInit() {
    let expectedInit = expectation(description: "Waiting for single init.")
    var memo = Memo<Int> {
      defer { expectedInit.fulfill() }
      return 26+16
    }
    
    XCTAssertEqual(42, memo.value())
    XCTAssertEqual(42, memo.value())
    XCTAssertEqual(42, memo.value())

    wait(for: [expectedInit], timeout: 1)
  }
  
  
  func testInvalidation() {
    var state = 42
    let memo = Memo<Int> { state }

    XCTAssertEqual(42, memo.value())
    XCTAssertEqual(42, memo.value())
    state = 64
    XCTAssertEqual(42, memo.value())
    memo.invalidate()
    XCTAssertEqual(64, memo.value())
    XCTAssertEqual(64, memo.value())
  }
}
