import Foundation



extension Array {
    /**
     This is functionally identical to the `+` operator for `Array`s. But Swift doesn’t provide a function version of it, and sometimes when chaining calls, using the this function instead of `+` can help readability. 
     */
    public func appending(contentsOf col: [Element]) -> [Element] {
        return self + col
    }
}



