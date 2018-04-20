import XCTest
import BagOfTricks



class MaybeMemoTests: XCTestCase {
  func testSingleInit() {
    let expectedInit = expectation(description: "Waiting for single init.")
    
    var memo = MaybeMemo<Int> {
      defer { expectedInit.fulfill() }
      return 26 + 16
    }

    XCTAssertEqual(42, memo.value())
    XCTAssertEqual(42, memo.value())
    XCTAssertEqual(42, memo.value())
    wait(for: [expectedInit], timeout: 1)
  }
  
  
  func testNilFactory() {
    let memo = MaybeMemo<Int> { nil }
    XCTAssertNil(memo.value())
    XCTAssertNil(memo.value())
    XCTAssertNil(memo.value())
  }
  
  
  func testInvalidation() {
    var state = 42
    let memo = MaybeMemo<Int> { state }
    
    XCTAssertEqual(42, memo.value())
    XCTAssertEqual(42, memo.value())
    memo.invalidate()
    XCTAssertEqual(42, memo.value())
    state = 64
    XCTAssertEqual(42, memo.value())
    memo.invalidate()
    XCTAssertEqual(64, memo.value())
  }
  
  
  func testMaybeFactoryDoesNotCacheNil() {
    var state = true
    let memo = MaybeMemo<Int> { state ? 42 : nil }
    
    XCTAssertEqual(42, memo.value())
    XCTAssertEqual(42, memo.value())
    state = false
    memo.invalidate()
    XCTAssertNil(memo.value())
    XCTAssertNil(memo.value())
    state = true
    //No invalidate!
    XCTAssertEqual(42, memo.value())
    XCTAssertEqual(42, memo.value())
  }
}
