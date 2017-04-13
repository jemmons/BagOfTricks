import Foundation
import XCTest
import BagOfTricks



class DebounceTests: XCTestCase {
  func testDebounced() {
    let lastCall = expectation(description: "last async call")
    var count: Int = 0
    let debounce = Debounce(threshold: 0.2, refractoryPeriod: nil) {
      count += 1
    }

    debounce.requestPerformance()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      debounce.requestPerformance()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      debounce.requestPerformance()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      lastCall.fulfill()
    }

    waitForExpectations(timeout: 1) { _ in
      XCTAssertEqual(count, 1)
    }
  }


  func testNotDebounced() {
    let lastCall = expectation(description: "last async call")
    var count: Int = 0
    let debounce = Debounce(threshold: 0.1, refractoryPeriod: nil) {
      count += 1
    }

    debounce.requestPerformance()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      debounce.requestPerformance()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
      debounce.requestPerformance()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      lastCall.fulfill()
    }

    waitForExpectations(timeout: 1) { _ in
      XCTAssertEqual(count, 3)
    }
  }


  func testRefractory() {
    let lastCall = expectation(description: "last async call")
    var count: Int = 0
    let debounce = Debounce(threshold: 0.1, refractoryPeriod: 0.2) {
      count += 1
    }

    debounce.requestPerformance()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      debounce.requestPerformance()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
      debounce.requestPerformance()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      lastCall.fulfill()
    }

    waitForExpectations(timeout: 1) { _ in
      XCTAssertEqual(count, 2)
    }
  }

}


