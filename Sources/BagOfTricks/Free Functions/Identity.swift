import Foundation



/**
 An identity function. It returns the thing it was given.
 
 Why? For `compactMap`:
 
 ```
 let xs = [1, 2, nil, 4]
 xs.compactMap { $0 } //> [1, 2, 3]
 xc.compactMap(id)    //> [1, 2, 3]
 ```
 
 - Parameter itself: The value to pass through unchanged.
 */
public func id<T>(itself: T?) -> T? {
  return itself
}
