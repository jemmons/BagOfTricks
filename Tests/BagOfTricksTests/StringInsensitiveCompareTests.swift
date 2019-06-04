import Foundation
import XCTest
import BagOfTricks



class CaseInsensitiveCompareTests: XCTestCase {
  let lower = "foo"
  let upper = "Foo"
  let diacritic = "föö"
  let fullWidth = "fｏｏ"
  lazy var all: [String] = [self.lower, self.upper, self.diacritic, self.fullWidth]

  
  func testLowerCase() {
    all.forEach { XCTAssert(lower ==* $0) }
  }
  
  
  func testCamelCase() {
    all.forEach { XCTAssert(upper ==* $0) }
  }
  
  
  func testDiacriticals() {
    all.forEach { XCTAssert(diacritic ==* $0) }
  }
  
  
  func testFullWidthCharacters() {
    all.forEach { XCTAssert(fullWidth ==* $0) }
  }
  
  
  func testNegative() {
    all.forEach { XCTAssertFalse("bar" ==* $0) }
  }
}
