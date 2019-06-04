import Foundation
import XCTest
import BagOfTricks



class ProperFractionTests: XCTestCase {
  func testThrows() {
    let expectsHighError = expectation(description: "Waiting for error for being too big.")
    let expectsLowError = expectation(description: "Waiting for error for being too low.")
    let expectsNoError = expectation(description: "Waiting for initialization without incident.")

    do {
      _ = try ProperFraction(14/13)
    } catch ProperFraction.Error.outOfRange(let d) {
      XCTAssertEqual(14/13, d)
      expectsHighError.fulfill()
    } catch {
      XCTFail()
    }
    
    do {
      _ = try ProperFraction(-1/3)
    } catch ProperFraction.Error.outOfRange(let d) {
      XCTAssertEqual(-1/3, d)
      expectsLowError.fulfill()
    } catch {
      XCTFail()
    }
    
    do {
      let v = try ProperFraction(1/2).value
      XCTAssertEqual(1/2, v)
      expectsNoError.fulfill()
    } catch {
      XCTFail()
    }

    wait(for: [expectsHighError, expectsLowError, expectsNoError], timeout: 1.0)
  }
  
  
  func testBoundaries() {
    let lowBound: Double = 0/1
    let highBound: Double = 1/1
    
    _ = try! ProperFraction(lowBound)
    _ = try! ProperFraction(highBound)
    XCTAssertEqual(lowBound, ProperFraction(clipping: lowBound).value)
    XCTAssertEqual(highBound, ProperFraction(clipping: highBound).value)

    XCTAssertEqual(lowBound, ProperFraction(clipping: -1/3).value)
    XCTAssertEqual(highBound, ProperFraction(clipping: 14/13).value)
  }
  
  
  func testDescription() {
    XCTAssertEqual("100%", try! String(describing: ProperFraction(4/4)))
    XCTAssertEqual("33.33%", try! String(describing: ProperFraction(1/3)))
    XCTAssertEqual("0%", try! String(describing: ProperFraction(0/4)))
  }
}
