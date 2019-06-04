import Foundation
import XCTest
import BagOfTricks



class LockboxTests: XCTestCase {
  private class DeallocRunner {
    let onDealloc: ()->Void
    init(_ onDealloc: @escaping ()->Void) {
      self.onDealloc = onDealloc
    }
    deinit {
      onDealloc()
    }
  }

  func testStrongOwnership() {
    var controlDeallocd = false
    var control: DeallocRunner? = DeallocRunner {
      controlDeallocd = true
    }
    control = nil
    XCTAssert(controlDeallocd)
    
    var keepDeallocd = false
    var keep: DeallocRunner? = DeallocRunner {
      keepDeallocd = true
    }
    let lockbox = Lockbox(keep: keep)
    keep = nil
    XCTAssertFalse(keepDeallocd)
  }
}
