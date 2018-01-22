import XCTest
import BagOfTricks



class MaybesTests: XCTestCase {
  func testURLMaybes() {
    XCTAssertNil(URL(maybeString: nil))
    XCTAssertNil(URL(maybeString: "💩"))
    XCTAssertEqual(URL(maybeString: "foo")!.absoluteString, "foo")
  }
}
