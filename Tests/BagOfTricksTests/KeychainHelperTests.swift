import XCTest
import BagOfTricks



class KeychainHelperTests: XCTestCase {
  func testCreateFetchDeleteExisXCTAssert() {
    let key = "testing.foo"
    XCTAssertNil(KeychainHelper.data(for: key))
    XCTAssertFalse(KeychainHelper.hasData(for: key))
    
    KeychainHelper.store(Data("foo".utf8), for: key)
    XCTAssertEqual("foo", String(data: KeychainHelper.data(for: key)!, encoding: .utf8))
    XCTAssert(KeychainHelper.hasData(for: key))

    KeychainHelper.remove(key: key)
    XCTAssertNil(KeychainHelper.data(for: key))
    XCTAssertFalse(KeychainHelper.hasData(for: key))
  }

  
  func testCreateFetchString() {
    let key = "testing.foo"
    defer { KeychainHelper.remove(key: key) }
    
    XCTAssertNil(KeychainHelper.string(for: key))
    
    KeychainHelper.store("foo", for: key)
    XCTAssertEqual("foo", KeychainHelper.string(for: key))
  }

  
  func testCreateExistingData() {
    let key = "testing.foo"
    defer { KeychainHelper.remove(key: key) }
    
    KeychainHelper.store(Data("foo".utf8), for: key)
    XCTAssertEqual("foo", String(data: KeychainHelper.data(for: key)!, encoding: .utf8)!)
    
    KeychainHelper.store(Data("bar".utf8), for: key)
    XCTAssertEqual("bar", String(data: KeychainHelper.data(for: key)!, encoding: .utf8)!)
  }

  
  func testCreateExistingString() {
    let key = "testing.foo"
    defer { KeychainHelper.remove(key: key) }
    
    KeychainHelper.store("foo", for: key)
    XCTAssertEqual("foo", KeychainHelper.string(for: key))
    
    KeychainHelper.store("bar", for: key)
    XCTAssertEqual("bar", KeychainHelper.string(for: key))
  }


  func testDeleteNonexisting() {
    KeychainHelper.remove(key: "nonexisting")
    KeychainHelper.remove(key: "nonexisting")
    XCTAssert(true)
  }
  
  
  func testUpdateFromNotAccessible() {
    let key = "testing.foo"
    defer { KeychainHelper.remove(key: key) }

    let addQuery: NSDictionary = [kSecAttrService: key, kSecClass: kSecClassGenericPassword, kSecValueData: Data("first".utf8)]
    let updateQuery: NSDictionary = [kSecAttrService: key, kSecClass: kSecClassGenericPassword]
    let updateValue: NSDictionary = [kSecValueData: Data("second".utf8), kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock]

    let addStatus = SecItemAdd(addQuery, nil)
    XCTAssertEqual(addStatus, errSecSuccess)
    
    XCTAssert(isAccessible(key: key, accessibility: kSecAttrAccessibleWhenUnlocked))
    
    #if os(iOS)
    // MacOS seems to enable AccessibleAfterFirstUnlock by defaul.
    XCTAssertFalse(isAccessible(key: key, accessibility: kSecAttrAccessibleAfterFirstUnlock))
    #endif

    let updateStatus = SecItemUpdate(updateQuery, updateValue)
    switch updateStatus {
    case errSecSuccess:
      XCTAssert(true)
    default:
      XCTFail()
    }

    XCTAssert(isAccessible(key: key, accessibility: kSecAttrAccessibleAfterFirstUnlock))
    XCTAssertEqual(KeychainHelper.string(for: key), "second")
  }
  
  
  func testUpdateFromAccessible() {
    let key = "testing.foo"
    defer { KeychainHelper.remove(key: key) }
    
    let addQuery: NSDictionary = [kSecAttrService: key, kSecClass: kSecClassGenericPassword, kSecValueData: Data("first".utf8), kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock]
    let updateQuery: NSDictionary = [kSecAttrService: key, kSecClass: kSecClassGenericPassword]
    let updateValue: NSDictionary = [kSecValueData: Data("second".utf8), kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock]
    
    let addStatus = SecItemAdd(addQuery, nil)
    switch addStatus {
    case errSecSuccess:
      XCTAssert(true)
    default:
      XCTFail()
    }
    
    XCTAssert(isAccessible(key: key, accessibility: kSecAttrAccessibleAfterFirstUnlock))

    let updateStatus = SecItemUpdate(updateQuery, updateValue)
    switch updateStatus {
    case errSecSuccess:
      XCTAssert(true)
    default:
      XCTFail()
    }
    
    XCTAssert(isAccessible(key: key, accessibility: kSecAttrAccessibleAfterFirstUnlock))
    XCTAssertEqual(KeychainHelper.string(for: key), "second")
  }
  
  
  func testAddsAreAccessibleGoingForward() {
    let key = "testing.foo"
    defer { KeychainHelper.remove(key: key) }
    
    KeychainHelper.store("hello", for: key)
    
    XCTAssert(isAccessible(key: key, accessibility: kSecAttrAccessibleAfterFirstUnlock))
  }
  
  
  func testUpdatesAreAccessibleGoingForward() {
    let key = "testing.foo"
    defer { KeychainHelper.remove(key: key) }
    
    let query: NSDictionary = [kSecAttrService: key, kSecClass: kSecClassGenericPassword, kSecValueData: Data("first".utf8)]
    let addStatus = SecItemAdd(query, nil)
    switch addStatus {
    case errSecSuccess:
      XCTAssert(true)
    default:
      XCTFail()
    }
    
    XCTAssert(isAccessible(key: key, accessibility: kSecAttrAccessibleWhenUnlocked))
    #if os(iOS)
    // MacOS seems to enable AccessibleAfterFirstUnlock by defaul.
    XCTAssertFalse(isAccessible(key: key, accessibility: kSecAttrAccessibleAfterFirstUnlock))
    #endif

    KeychainHelper.store("second", for: key)
    
    XCTAssert(isAccessible(key: key, accessibility: kSecAttrAccessibleAfterFirstUnlock))
    XCTAssertEqual(KeychainHelper.string(for: key), "second")
  }
}



private extension KeychainHelperTests {
  func isAccessible(key: String, accessibility: CFString) -> Bool {
    var copyResult: CFTypeRef? = nil
    let query: NSDictionary = [kSecAttrService: key, kSecClass: kSecClassGenericPassword, kSecAttrAccessible: accessibility]
    let status = SecItemCopyMatching(query, &copyResult)
    switch status {
    case errSecSuccess:
      return true
    default:
      return false
    }
  }
}
