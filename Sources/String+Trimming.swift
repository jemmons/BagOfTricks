import Foundation



extension String {
  public var trimmingWhitespace: String {
    return trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  
  public var isBlank: Bool {
    return trimmingWhitespace.isEmpty
  }
  
  
  public var isNotBlank: Bool {
    return ❗️isBlank
  }
  
  
  public var maybeBlank:String?{
    return isBlank ? nil : self
  }
}
