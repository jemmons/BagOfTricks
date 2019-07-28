import Foundation
import XCTest
import BagOfTricks



class IdentityTests: XCTestCase {
  func testCompactMap() {
    XCTAssertEqual([1,2,4], [1,2,nil,4].compactMap(id))
    XCTAssertEqual(["a","b","d"], ["a","b",nil,"d"].compactMap(id))
    XCTAssertEqual([true,false,false], [true,false,nil,false].compactMap(id))
  }
}
