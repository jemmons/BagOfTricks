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

  
  func testBindObjectThenValue() {
    let binding = BindIfReady<Label, String> { $0.text = $1 }
    XCTAssertNil(binding.object)
    XCTAssertNil(binding.value)
    binding.object = Label()
    XCTAssertNotNil(binding.object)
    XCTAssertNil(binding.object!.text)
    binding.value = "Hello"
    XCTAssertEqual(binding.object!.text, "Hello")
  }
  
  
  func testBindValueThenObject() {
    let binding = BindIfReady<Label, String> { $0.text = $1 }
    XCTAssertNil(binding.object)
    XCTAssertNil(binding.value)
    binding.value = "Hello"
    XCTAssertNotNil(binding.value)
    binding.object = Label()
    XCTAssertNotNil(binding.object)
    XCTAssertEqual(binding.object!.text, "Hello")
  }
  
  
  func testSwappingObjectsPostValue() {
    let binding = BindIfReady<Label, String> { $0.text = $1 }

    binding.value = "Hello"
    binding.object = Label()
    XCTAssertEqual(binding.object!.text, "Hello")

    binding.object = Label()
    XCTAssertNil(binding.object!.text)
  }

  
  func testWeakBinding() {
    let binding = WeakBindIfReady<Label, String> { $0.text = $1 }
    binding.object = Label()
    XCTAssertNil(binding.object)
    
    let myLabel = Label()
    binding.object = myLabel
    XCTAssertNotNil(binding.object)

    XCTAssertNil(binding.object!.text)
    binding.value = "Hello"
    XCTAssertEqual(binding.object!.text, "Hello")
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
  
  
  func testWeakFillableBinding() {
    let binding = WeakFillIfReady<Label>()
    XCTAssertNil(binding.object)
    XCTAssertNil(binding.value)
    
    binding.value = Model(value: "foo")
    XCTAssertNotNil(binding.value)

    binding.object = Label()
    XCTAssertNil(binding.object)
    XCTAssertNil(binding.value, "This may not be obvious, but the `object` existed long enough to be bound to the value before being dealloc’d. Thus `value` got reset to `nil`")
    
    let label = Label()
    binding.value = Model(value: "bar")
    binding.object = label
    XCTAssertNotNil(binding.object)
    XCTAssertNotNil(label)
    XCTAssertEqual(binding.object!.text, "bar")
    XCTAssertNil(binding.value)
  }
}
