import XCTest
import BagOfTricks



class CartesianProductSequenceTests: XCTestCase {
  func testPermuteCollections() {
    var insideLoop = false
    
    let subject = product(1...2, ["a", "b"])
    let array = [(1,"a"), (1,"b"), (2,"a"), (2,"b")]
    for (i, t) in subject.enumerated() {
      insideLoop = true
      XCTAssertEqual(t.0, array[i].0)
      XCTAssertEqual(t.1, array[i].1)
    }
    
    XCTAssert(insideLoop)
  }
}
