import Foundation
import XCTest
import BagOfTricks



class OptionalThrowingTests: XCTestCase {
  enum MyError: Error {
    case totallyNil
  }
  
  
  func testThrows() {
    let subject: String? = nil
    do {
      _ = try subject.unwrapped(or: MyError.totallyNil)
      XCTFail()
    } catch MyError.totallyNil {
      XCTAssert(true)
    } catch {
      XCTFail()
    }
  }
  
  
  func testUnwraps() {
    let subject: String? = "hello"
    do {
      let value = try subject.unwrapped(or: MyError.totallyNil)
      XCTAssertEqual(value, "hello")
    } catch {
      XCTFail()
    }
  }
}
