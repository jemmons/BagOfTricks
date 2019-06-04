import XCTest
import BagOfTricks





class DelegatedCallTests: XCTestCase {
  let localString = "local string"
  
  
  func testCycleExamples() {
    class A {
      var delegate: (()->Void)?
    }
    
    class B {
      let a = A()
      
      func f() {}
      
      init() {
        a.delegate = { self.f() }
      }
    }

    weak var a = A()
    XCTAssertNil(a)
    
    weak var b = B()
    XCTAssertNotNil(b)
  }
  
  
  func testBreaksCycles() {
    class A {
      var delegate = DelegatedCall<A>()
    }
    
    class B {
      let a = A()
      
      func f() {}
      
      init() {
        a.delegate.delegate(to: self) { context, _ in
          context.f()
        }
      }
    }
    
    
    weak var a = A()
    XCTAssertNil(a)
    
    weak var b = B()
    XCTAssertNil(b)
  }
  
  
  
  func testPassesValue() {
    let expectsValue = expectation(description: "Waiting for value to be passed.")
    
    class A {
      var shouldPrint = DelegatedCall<String>()
      
      func print() {
        shouldPrint.perform?("Hello")
      }
    }
    
    let a = A()
    a.shouldPrint.delegate(to: self) { _, value in
      XCTAssertEqual("Hello", value)
      expectsValue.fulfill()
    }
    
    a.print()
    
    wait(for: [expectsValue], timeout: 1)
  }
  
  
  func testValidContext() {
    let expectsContext = expectation(description: "Waiting for context to be passed.")

    class A {
      var shouldPrint = DelegatedCall<String>()
      
      func print() {
        shouldPrint.perform?("Hello")
      }
    }

    let a = A()
    a.shouldPrint.delegate(to: self) { context, _ in
      XCTAssertEqual("local string", context.localString)
      expectsContext.fulfill()
    }
    
    a.print()
    
    wait(for: [expectsContext], timeout: 1)
  }
}
