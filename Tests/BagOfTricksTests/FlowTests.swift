import XCTest
import BagOfTricks



class FlowTests:XCTestCase {
  func testGiven() {
    let returning = given(NSMutableString(string: "hello")) { it in
      XCTAssertEqual("hello", it)
      it.append(", world")
    }
    XCTAssertEqual("hello, world", returning)
  }
  
  
  func testWith() {
    with(1) { one in
      XCTAssertEqual(1, one)
    }
  }
  
  
  func testWith2() {
    with(1, 2) { one, two in
      XCTAssertEqual(1, one)
      XCTAssertEqual(2, two)
    }
  }
  
  
  func testWith3() {
    with(1, 2, 3) { one, two, three in
      XCTAssertEqual(1, one)
      XCTAssertEqual(2, two)
      XCTAssertEqual(3, three)
    }
  }
  
  
  func testWith4() {
    with(1, 2, 3, 4) { one, two, three, four in
      XCTAssertEqual(1, one)
      XCTAssertEqual(2, two)
      XCTAssertEqual(3, three)
      XCTAssertEqual(4, four)
    }
  }
}


