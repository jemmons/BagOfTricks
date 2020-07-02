//import XCTest
//import BagOfTricks
//
//
//private class Ref {
//  var value: String?
//  var count: Int = 0
//}
//private let ref = Ref()
//
//
//class ForgetfulWrapperTests: XCTestCase {
//  // This strange formulation of passing the closure in a param instead of as a default value is [required by SR-10950](https://bugs.swift.org/browse/SR-10950). It will probably be fixed in the next Swift release following 5.1.
//  @Forgetful(wrappedValue: {
//    ref.count += 1
//    return ref.value!
//  }()) var lazy: String
//  
//  
//  override func setUp() {
//    ref.value = nil
//    ref.count = 0
//  }
//
//
//  func testIsLazy() {
//    XCTAssertNil(ref.value)
//    XCTAssertEqual(ref.count, 0)
//    ref.value = "foo"
//    XCTAssertEqual(lazy, "foo")
//    XCTAssertEqual(ref.count, 1)
//
//    _ = lazy
//    _ = lazy
//    _ = lazy
//    XCTAssertEqual(ref.count, 1)
//
//    ref.value = "bar"
//
//    _ = lazy
//    XCTAssertEqual(lazy, "foo")
//    XCTAssertEqual(ref.count, 1)
//  }
//  
//  
//  func testForget() {
//    ref.value = "foo"
//    _ = lazy
//    ref.value = "bar"
//    
//    $lazy.forget()
//    XCTAssertEqual(lazy, "bar")
//    XCTAssertEqual(ref.count, 2)
//  }
//  
//  
//  func testForgetIsLazy() {
//    ref.value = "foo"
//    _ = lazy
//    ref.value = "bar"
//    _ = lazy
//    XCTAssertEqual(lazy, "foo")
//    XCTAssertEqual(ref.count, 1)
//
//    $lazy.forget()
//    XCTAssertEqual(lazy, "bar")
//    XCTAssertEqual(ref.count, 2)
//    
//    _ = lazy
//    _ = lazy
//    _ = lazy
//    XCTAssertEqual(lazy, "bar")
//    XCTAssertEqual(ref.count, 2)
//  }
//  
//}
