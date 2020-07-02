//import XCTest
//import BagOfTricks
//
//
//
//class ForgetfulTests: XCTestCase {
//  func testFactoryCalls() {
//    let factoryCalled = expectation(description: "Forgetful has reinitialized its value")
//    factoryCalled.expectedFulfillmentCount = 2
//    
//    var subject = Forgetful<Int>(wrappedValue: {
//      factoryCalled.fulfill()
//      return 42
//    }())
//    
//    XCTAssertEqual(subject.wrappedValue, 42)
//    XCTAssertEqual(subject.wrappedValue, 42)
//    XCTAssertEqual(subject.wrappedValue, 42)
//    subject.forget()
//    XCTAssertEqual(subject.wrappedValue, 42)
//    XCTAssertEqual(subject.wrappedValue, 42)
//    XCTAssertEqual(subject.wrappedValue, 42)
//
//    wait(for: [factoryCalled], timeout: 0)
//  }
//  
//  
//  func testForgets() {
//    class Ref {
//      var value: String = "hello"
//    }
//    let ref = Ref()
//
//    var subject = Forgetful(wrappedValue: ref.value)
//
//    XCTAssertEqual(subject.wrappedValue, "hello")
//    ref.value = "foo"
//    XCTAssertEqual(subject.wrappedValue, "hello")
//    subject.forget()
//    XCTAssertEqual(subject.wrappedValue, "foo")
//  }
//
//
//  func testLazy() {
//    let subject = Forgetful<Int>(wrappedValue: {
//      XCTFail()
//      return 42
//    }())
//
//    XCTAssertNotNil(subject)
//  }
//
//
//  func testLazyForget() {
//    let factoryCalled = expectation(description: "Forgetful has reinitialized its value")
//
//    var subject = Forgetful<Int>(wrappedValue: {
//      factoryCalled.fulfill()
//      return 42
//    }())
//
//    XCTAssertEqual(subject.wrappedValue, 42)
//    XCTAssertEqual(subject.wrappedValue, 42)
//    XCTAssertEqual(subject.wrappedValue, 42)
//    subject.forget()
//    subject.forget()
//    subject.forget()
//    subject.forget()
//    subject.forget()
//
//    wait(for: [factoryCalled], timeout: 0)
//  }
//}
