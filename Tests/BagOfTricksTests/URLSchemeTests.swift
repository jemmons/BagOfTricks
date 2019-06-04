import XCTest
import BagOfTricks



class URLSchemeTests: XCTestCase {
  let validSchemes = [
    "http",
    "mailto",
    "frum1",
    "dig+",
    "gal.",
    "mate-",
    "a+",
    "x",
    "tricked-out+2the.max",
  ]
  let invalidSchemes = [
    "",
    "1",
    "+",
    "-",
    ".",
    "2bad",
    "+one",
    "-bullet",
    ".com",
    "résumé",
    "cheating:",
    "toosoon/",
    "bad%20escape",
    "also\not",
    "two words"
  ]
  
  
  func testValid() {
    validSchemes.forEach { scheme in
      XCTAssertNotNil(try? URL.Scheme(scheme))
    }
  }
  
  
  func testLowercase() {
    XCTAssertEqual(try! URL.Scheme("HTTP").value, "http")
  }
  
  
  func testValidsDontCrash() {
    validSchemes.forEach { scheme in
      var comps = URLComponents()
      comps.scheme = try! URL.Scheme(scheme).value
    }
  }
  
  
  func testInvalid() {
    invalidSchemes.forEach { scheme in
      XCTAssertNil(try? URL.Scheme(scheme))
    }
  }
  
  
  func testCatchLength() {
    let expectedThrow = expectation(description: "Waiting for requiredLength error")
    do {
      _ = try URL.Scheme("")
    } catch URL.Scheme.Format.requiredLength {
      expectedThrow.fulfill()
    } catch {
      XCTFail()
    }
    
    wait(for: [expectedThrow], timeout: 0)
  }
  
  
  func testCatchFirstCharacter() {
    let expectedThrow = expectation(description: "Waiting for invalidFirstCharacter error")
    do {
      _ = try URL.Scheme("1foo")
    } catch URL.Scheme.Format.invalidFirstCharacter {
      expectedThrow.fulfill()
    } catch {
      XCTFail()
    }
    
    wait(for: [expectedThrow], timeout: 0)
  }

  
  func testCatchInvalidCharacter() {
    let expectedThrow = expectation(description: "Waiting for invalidCharacters error")
    do {
      _ = try URL.Scheme("fo!o")
    } catch URL.Scheme.Format.invalidCharacters {
      expectedThrow.fulfill()
    } catch {
      XCTFail()
    }
    
    wait(for: [expectedThrow], timeout: 0)
  }

  
  func testReplacingScheme() {
    let subject = URL(string: "http://example.com")!
    let newScheme = try! URL.Scheme("test")
    XCTAssertEqual(subject.replacing(scheme: newScheme).scheme, "test")
    
    validSchemes.forEach { schemeString in
      let scheme = try! URL.Scheme(schemeString)
      XCTAssertEqual(subject.replacing(scheme: scheme).scheme, schemeString)
    }
  }
  
  
  func testMatcher() {
    let http = URL(string: "http://example.com")!
    switch http {
    case try! URL.Scheme("foo"):
      XCTFail()
    case try! URL.Scheme("http"):
      XCTAssert(true)
    default:
      XCTFail()
    }
    
    let foo = URL(string: "foo://example.com")!
    if case try! URL.Scheme("foo") = foo {
      XCTAssert(true)
    } else {
      XCTFail()
    }
  }
}
