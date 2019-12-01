import Foundation
import XCTest
import BagOfTricks



class DebounceTests: XCTestCase {
  func testDebounced() {
    let lastCall = expectation(description: "last async call")
    var count: Int = 0
    let debounce = Debounce(threshold: 0.3, refractoryPeriod: nil) {
      count += 1
    }

    debounce.requestPerformance()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      debounce.requestPerformance()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      debounce.requestPerformance()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      lastCall.fulfill()
    }

    waitForExpectations(timeout: 2) { _ in
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
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      debounce.requestPerformance()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      debounce.requestPerformance()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      lastCall.fulfill()
    }

    waitForExpectations(timeout: 2) { _ in
      XCTAssertEqual(count, 3)
    }
  }


  func testRefractory() {
    let lastCall = expectation(description: "last async call")
    var count: Int = 0
    let debounce = Debounce(threshold: 0.1, refractoryPeriod: 0.6) {
      count += 1
    }

    debounce.requestPerformance() // Count +1
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      debounce.requestPerformance() // Outside of threshold, but within refractory.
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
      debounce.requestPerformance() // Outside of initial refractory (refractory only resets on success). Count +1
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
      lastCall.fulfill()
    }

    waitForExpectations(timeout: 2) { _ in
      XCTAssertEqual(count, 2)
    }
  }

}


