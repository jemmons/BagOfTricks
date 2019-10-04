import Foundation



// Based off Quinn's code at https://forums.developer.apple.com/message/264391 re: "Keychain access in Xcode 9"
public enum KeychainHelper {}



// MARK: - PUBLIC
public extension KeychainHelper {
  // MARK: PREDICATES
  static func hasData(for key: String) -> Bool {
    var copyResult: CFTypeRef?
    
    let status = SecItemCopyMatching(Helper.makeQuery(with: key), &copyResult)
    switch status {
    case errSecItemNotFound:
      return false
    default:
      // Note that the keychain could have data, but it's null or inaccessable due to lock. So we can't just compare `data(for:)` to `nil`.
      return true
    }
  }
  
  
  // MARK: Read
  static func data(for key: String) -> Data? {
    var copyResult: CFTypeRef?
    
    let status = SecItemCopyMatching(Helper.makeQuery(with: key, append: [kSecReturnData: true]), &copyResult)
    switch status {
    case errSecSuccess:
      guard let someRef = copyResult else {
        return nil
      }
      guard let data = someRef as? Data else {
        fatalError("Keychain failed to return Data even when explicitly asked to do so.")
      }
      return data
    case errSecItemNotFound:
      return nil
    case errSecInteractionNotAllowed:
      // We'll get this when the device is locked and the service hasn't been added with `kSecAttrAccessibleAfterFirstUnlock`. Moving forward, all items will be stored with this attribute, so this will become less necessary over time.
      return nil
    default:
      fatalError("Keychain failed to load service “\(key)” (code: \(status)).")
    }
  }
  
  
  static func string(for key: String) -> String? {
    guard let data = data(for: key) else {
      return nil
    }
    return String(data: data, encoding: .utf8)
  }
  

  // MARK: Create & Update
  static func store(_ newData: Data, for key: String) {
    switch hasData(for: key) {
    case true:
      Helper.update(data: newData, for: key)
    case false:
      Helper.add(data: newData, for: key)
    }
  }
  
  
  static func store(_ string: String, for key: String) {
    store(Data(string.utf8), for: key)
  }
  
  
  // MARK: Delete
  static func remove(key: String) {
    let status = SecItemDelete(Helper.makeQuery(with: key))
    guard [errSecSuccess, errSecItemNotFound].contains(status) else {
      fatalError("Keychain failed to remove service “\(key)” (code: \(status)).")
    }
  }
  
  
  static func nukeFromOrbit() {
    let matchEverythingQuery: NSDictionary = [kSecClass: kSecClassGenericPassword]
    let status = SecItemDelete(matchEverythingQuery)
    guard [errSecSuccess, errSecItemNotFound].contains(status) else {
      fatalError("Keychain failed to burn the fields and salt the earth (code: \(status)).")
    }
  }
}



// MARK: - HELPER
private enum Helper {
  static func makeQuery(with service: String, append: [CFString: Any] = [:]) -> NSDictionary {
    return [kSecClass: kSecClassGenericPassword, kSecAttrService: service].merging(append) { $1 } as NSDictionary
  }
  
  
  static func update(data: Data, for key: String) {
    let status = SecItemUpdate(makeQuery(with: key), [kSecValueData: data, kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock] as NSDictionary)
    guard status == errSecSuccess else {
      fatalError("Keychain failed to update service “\(key)” (code: \(status)).")
    }
  }
  
  
  static func add(data: Data, for key: String) {
    let status = SecItemAdd(makeQuery(with: key, append: [kSecValueData: data, kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock]), nil)
    guard status == errSecSuccess else {
      fatalError("Keychain failed to create service “\(key)” (code: \(status)).")
    }
  }
}
