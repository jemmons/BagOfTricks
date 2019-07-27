import Foundation



@available(iOS, deprecated: 13, message: "Use Apple’s `Combine` framework instead.")
@available(macOS, deprecated: 10.15, message: "Use Apple’s `Combine` framework instead.")
public class Debounce {
  private let threshold: TimeInterval
  private let refractoryPeriod: TimeInterval?
  weak private var timer: Timer?
  private var isRefractory: Bool = false
  private let handler: ()->Void
  
  
  public init(threshold: TimeInterval, refractoryPeriod: TimeInterval? = 1, perform: @escaping ()->Void) {
    self.threshold = threshold
    self.refractoryPeriod = refractoryPeriod
    handler = perform
  }
  
  
  deinit {
    timer?.invalidate()
  }
}



public extension Debounce {
  func requestPerformance() {
    timer?.invalidate()
    
    guard isRefractory == false else {
      return
    }
    
    resetTimer()
  }
}



private extension Debounce {
  func resetTimer() {
    timer = given(Timer(timeInterval: threshold, target: self, selector: #selector(debounceTimeUp), userInfo: nil, repeats: false)) {
      RunLoop.current.add($0, forMode: .commonModes)
    }
  }
  
  
  @objc func debounceTimeUp() {
    handler()
    enterRefractoryPeriod()
  }
  
  
  func enterRefractoryPeriod() {
    // If `refractoryPeriod` is nil, we never enter a refrectory mode and `requestPerformance()` will continute to trigger events.
    guard let interval = refractoryPeriod else {
      return
    }
    self.isRefractory = true
    let refractoryTimer = Timer(timeInterval: interval, target: self, selector: #selector(refractoryTimeUp), userInfo: nil, repeats: false)
    RunLoop.current.add(refractoryTimer, forMode: .commonModes)
  }
  
  
  @objc func refractoryTimeUp() {
    isRefractory = false
  }
}

