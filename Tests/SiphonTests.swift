import XCTest
import BagOfTricks



class SiphonTests: XCTestCase {
  struct Model {
    let value: String
  }
  
  
  class Label: Fillable {
    var text: String?
    func fill(with model: Model) {
      text = model.value
    }
  }
  
  
  class FakeViewController {
    var labelSiphon = Siphon<Label>()
    
    func prepareForSegue(model: Model) {
      labelSiphon.value = model
    }
    
    func viewDidLoad() {
      labelSiphon.object = Label()
    }
  }


  func testLateInitializtion() {
    let subject = FakeViewController()
    subject.prepareForSegue(model: Model(value: "First"))
    subject.viewDidLoad()
    XCTAssertEqual(subject.labelSiphon.object?.text, "First")
    subject.prepareForSegue(model: Model(value: "Second"))
    XCTAssertEqual(subject.labelSiphon.object?.text, "Second")
  }
  
  
  func testEarlyInitializtion() {
    let subject = FakeViewController()
    subject.viewDidLoad()
    subject.prepareForSegue(model: Model(value: "First"))
    XCTAssertEqual(subject.labelSiphon.object?.text, "First")
    subject.prepareForSegue(model: Model(value: "Second"))
    XCTAssertEqual(subject.labelSiphon.object?.text, "Second")
  }

}
