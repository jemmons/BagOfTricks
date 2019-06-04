import Foundation
import XCTest
@testable import BagOfTricks



class DictionaryMergeTests: XCTestCase {
  func testMerge() {
    XCTAssertEqual(["one": 1, "two": 2, "three":3].merging(from: ["three":42, "four":4, "five":5]), ["one":1, "two":2, "three":42, "four":4, "five":5])
  }


  func testMergeOperator() {
    XCTAssertEqual(["one": 1, "two": 2, "three":3] + ["three":42, "four":4, "five":5], ["one":1, "two":2, "three":42, "four":4, "five":5])
  }

  
  func testCardinality() {
    let x = ["one": 1, "two":2, "three":3]
    let y = ["one": 11, "two": 22]
    XCTAssertEqual( x + y, ["one": 11, "two":22, "three":3])
    XCTAssertEqual( y + x, x)
  }


  func testImmutability(){
    let target = ["one":1]
    let source = ["two":2]
    let added = target + source
    let merged = target.merging(from: source)
    let expected = ["one":1, "two":2]

    XCTAssertEqual(added, expected)
    XCTAssertEqual(merged, expected)
    //Pedantic clarity. Becasue these are constant, we don't really need to assert anything (the compiler will barf if we try to mutate them).
    XCTAssertEqual(target, ["one":1])
    XCTAssertEqual(source, ["two":2])
  }


  func testMutability(){
    var target = ["one":1]
    let source = ["two":2]
    let expected = ["one":1, "two":2]
    target.merge(from: source)
    XCTAssertEqual(target, expected, "Should have mutated.")
    XCTAssertEqual(source, ["two":2], "Should be constant.")
  }
}

