import Foundation



private var tickTockAbsoluteTime: UInt64?
private var _timebaseInfo: mach_timebase_info = mach_timebase_info(numer:0, denom:0)
private var timebaseRatio: Double {
  if _timebaseInfo.denom == 0 {
    mach_timebase_info(&_timebaseInfo)
  }
  return Double(_timebaseInfo.numer) / Double(_timebaseInfo.denom)
}



/**
 Put a stopwatch around a chunk of code, and print the time (in seconds) to the log.
 
 Note this uses two functions instead of a trailing closure for easier insertion into existing code (no  wrapping or re-indenting needed).
 
 Usage:
 ```
 TICK()
 //do things you want
 //to time here
 TOCK()
 ```
 
 - See: https://developer.apple.com/library/content/qa/qa1398/_index.html
 */
public func TICK() {
  assert(tickTockAbsoluteTime == nil)
  tickTockAbsoluteTime = mach_absolute_time()
}



/**
 Put a stopwatch around a chunk of code, and print the time (in seconds) to the log.
 
 Note this uses two functions instead of a trailing closure for easier insertion into existing code (no  wrapping or re-indenting needed).
 
 Usage:
 ```
 TICK()
 //do things you want
 //to time here
 TOCK()
 ```
 
 - See: https://developer.apple.com/library/content/qa/qa1398/_index.html
 */
public func TOCK(_ name: String = #function) {
  assert(tickTockAbsoluteTime != nil)
  let interval = mach_absolute_time() - tickTockAbsoluteTime!
  tickTockAbsoluteTime = nil
  let nanoInterval = Double(interval) * timebaseRatio
  print("\n⏱\(name): \(nanoInterval/1_000_000_000.0)s\n")
}
