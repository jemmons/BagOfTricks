import Foundation

public extension URL {
  public struct Scheme {
    enum Format: LocalizedError {
      case requiredLength
      case invalidFirstCharacter
      case invalidCharacters
      
      
      var errorDescription: String? {
        switch self {
        case .requiredLength:
          return "A scheme must contain at least one character."
        case .invalidFirstCharacter:
          return "Schemes must have a letter as their first character."
        case .invalidCharacters:
          return "Schemes can only contain letters, numbers, periods (.), pluses (+), and hyphens (-)."
        }
      }
    }
    public let value: String!
    
    
    public init(_ value: String) throws {
      self.value = value.lowercased()
      try validate()
    }
  }
  
  
  public func replacing(scheme: Scheme) -> URL {
    guard var comps = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
      fatalError("URL “\(self.absoluteString)” composed of invalid components.")
    }
    comps.scheme = scheme.value
    guard let newURL = comps.url else {
      fatalError("Valid URL components resulted in invalid URL.")
    }
    return newURL
  }
}



private extension URL.Scheme {
  private static let validFirstCharacters: Set<Character> = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  private static let validCharacters: Set<Character> = validFirstCharacters.union(["+", "-", ".", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"])
  
  func validate() throws {
    guard let first = value.first else {
      throw Format.requiredLength
    }
    guard URL.Scheme.validFirstCharacters.contains(first) else {
      throw Format.invalidFirstCharacter
    }
    guard (value.allSatisfy { URL.Scheme.validCharacters.contains($0) }) else {
      throw Format.invalidCharacters
    }
  }
}



public func ~=(pattern: URL.Scheme, value: URL) -> Bool {
  return pattern.value == value.scheme
}


#if swift(>=4.2)
//
#else
private extension Sequence {
  func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
    return try ❗️contains { try ❗️predicate($0) }
  }
}
#endif
