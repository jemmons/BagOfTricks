import XCTest
import BagOfTricks



class OscillatorTests: XCTestCase {
  func testCommensurateStep() {
    let i = Oscillator(lower: 0, upper: 10, step: 5)
    let iseq = IteratorSequence(i).prefix(6)
    XCTAssertEqual([0,5,10,5,0,5], Array(iseq))
    
    let f = Oscillator(lower: 0.0, upper: 1.0, step: 0.5)
    let fseq = IteratorSequence(f).prefix(6)
    XCTAssertEqual([0.0, 0.5, 1.0, 0.5, 0.0, 0.5], Array(fseq))
  }


  func testIncommensurateStep() {
    let i = Oscillator(lower: 0, upper: 10, step: 4)
    let iseq = IteratorSequence(i).prefix(6)
    XCTAssertEqual([0,4,8,4,0,4], Array(iseq))

    let f = Oscillator(lower: 0.0, upper: 1.0, step: 0.4)
    let fseq = IteratorSequence(f).prefix(6)
    XCTAssertEqual([0.0, 0.4, 0.8, 0.4, 0.0, 0.4], Array(fseq))
  }
  
  
  func testTooLargeStep() {
    let i = Oscillator(lower: 0, upper: 5, step: 6)
    let iseq = IteratorSequence(i)
    XCTAssert(Array(iseq).isEmpty)

    let f = Oscillator(lower: 0.0, upper: 1.0, step: 1.01)
    let fseq = IteratorSequence(f)
    XCTAssert(Array(fseq).isEmpty)
  }

  
  func testPerfectStep() {
    let i = Oscillator(lower: 0, upper: 5, step: 5)
    let iseq = IteratorSequence(i).prefix(4)
    XCTAssertEqual([0,5,0,5], Array(iseq))
    
    let f = Oscillator(lower: 0.0, upper: 1.0, step: 1.0)
    let fseq = IteratorSequence(f).prefix(4)
    XCTAssertEqual([0.0, 1.0, 0.0, 1.0], Array(fseq))
  }
  
}
