import XCTest
import BagOfTricks



class BindIfReadyTests: XCTestCase {
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
    var labelFiller = FillIfReady<Label>()

    func prepareForSegue(model: Model) {
      labelFiller.value = model
    }
    
    func viewDidLoad() {
      labelFiller.object = Label()
    }
  }

  
  func testFillableLateInitializtion() {
    let subject = FakeViewController()
    subject.prepareForSegue(model: Model(value: "First"))
    subject.viewDidLoad()
    XCTAssertEqual(subject.labelFiller.object?.text, "First")
    subject.prepareForSegue(model: Model(value: "Second"))
    XCTAssertEqual(subject.labelFiller.object?.text, "Second")
  }
  
  
  func testFillableEarlyInitializtion() {
    let subject = FakeViewController()
    subject.viewDidLoad()
    subject.prepareForSegue(model: Model(value: "First"))
    XCTAssertEqual(subject.labelFiller.object?.text, "First")
    subject.prepareForSegue(model: Model(value: "Second"))
    XCTAssertEqual(subject.labelFiller.object?.text, "Second")
  }
}
