import XCTest
import BagOfTricks



class ClampWrapperTests: XCTestCase {
  let upperBound = 10
  let lowerBound = 1
  @Clamp(range: 1...10) var closed: Int = 5
  @Clamp(range: ...10) var through: Int = 5
  @Clamp(range: 1...) var from: Int = 5
  
  @Clamp(range: 1...10) var closedBadDefault: Int = 100
  @Clamp(range: ...10) var throughBadDefault: Int = 100
  @Clamp(range: 1...) var fromBadDefault: Int = -100
  
  
  func testTooHigh() {
    let tooHigh = 100
    closed = tooHigh
    through = tooHigh
    from = tooHigh
    XCTAssertEqual(upperBound, closed)
    XCTAssertEqual(upperBound, through)
    XCTAssertEqual(tooHigh, from)
  }
  
  
  func testTooLow() {
    let tooLow = -100
    closed = tooLow
    through = tooLow
    from = tooLow

    XCTAssertEqual(lowerBound, closed)
    XCTAssertEqual(tooLow, through)
    XCTAssertEqual(lowerBound, from)
  }
  
  
  func testInRange() {
    let inRange = 5
    closed = inRange
    through = inRange
    from = inRange
    
    XCTAssertEqual(inRange, closed)
    XCTAssertEqual(inRange, through)
    XCTAssertEqual(inRange, from)
  }
  
  
  func testDefaults() {
    XCTAssertEqual(5, closed)
    XCTAssertEqual(5, through)
    XCTAssertEqual(5, from)
    
    XCTAssertEqual(upperBound, closedBadDefault)
    XCTAssertEqual(upperBound, throughBadDefault)
    XCTAssertEqual(lowerBound, fromBadDefault)
  }
}




