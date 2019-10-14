import XCTest
import BagOfTricks



class PositiveWrapperTests: XCTestCase {
  @Positive var int: Int = 5
  @Positive var float: Double = 5.5
  
  @Positive var intBadDefault: Int = -5
  @Positive var floatBadDefault: Double = -5.5
  
  @Positive(through: 10) var intThrough: Int = 5
  @Positive(through: 10.123) var floatThrough: Double = 5.5

  @Positive(through: 10) var intThroughBadDefault: Int = 15
  @Positive(through: 10.123) var floatThroughBadDefault: Double = 15.5

  func testDefaults() {
    XCTAssertEqual(5, int)
    XCTAssertEqual(5.5, float)
    
    XCTAssertEqual(0, intBadDefault)
    XCTAssertEqual(0, floatBadDefault)

    XCTAssertEqual(5, intThrough)
    XCTAssertEqual(5.5, floatThrough)

    XCTAssertEqual(10, intThroughBadDefault)
    XCTAssertEqual(10.123, floatThroughBadDefault)

  }
  
  
  func testAssignment() {
    int = 100
    XCTAssertEqual(100, int)
    
    float = 100.123
    XCTAssertEqual(100.123, float)
    
    int = -100
    XCTAssertEqual(0, int)
    
    float = -100.123
    XCTAssertEqual(0, float)
    
    intThrough = 100
    XCTAssertEqual(10, intThrough)
    
    floatThrough = 100.5
    XCTAssertEqual(10.123, floatThrough)
  }
}
