import Foundation



/**
 Lets us map from a completion passing a `Result` of one type to a waiting completion expecting a `Result` of another type. For example:
 
 ```
 func fetchString(completion: (Result<String, Error>)->Void) {
   myAPI.fetchNumber(completion: map(completion, transform: String.init)
 }
 ```
 
 This `map` will pass along `.failure`s and perform `transform` on the values of `.success`. If `transform` can throw, use `flatMap` instead, which will rewrap any thrown error in a new `Result`.
 */
public func map<FromValue, ToValue>(_ completion: @escaping (Result<ToValue, Error>)->Void, transform: @escaping (FromValue)->ToValue) -> (Result<FromValue, Error>)->Void {
    return { completion($0.map(transform)) }
}



/**
 Lets us map from a completion passing a `Result` of one type to a waiting completion expecting a `Result` of another type. For example:
 
 ```
 func fetchThing(completion: (Result<Thing, Error>)->Void) {
   myAPI.fetchJSON(completion: flatMap(completion) {
     try decoder.decode(Thing.self, from $0)
   })
 }
 ```
 
 This `flatMap` will handle any errors thrown, returning them as the `.failure` of the `Result`. If nothing in your mapping can throw, use `map`, instead.
 */
public func flatMap<FromValue, ToValue>(_ completion: @escaping (Result<ToValue, Error>)->Void, transform: @escaping (FromValue)throws->ToValue) -> (Result<FromValue, Error>)->Void {
    return { completion($0.flatMap { from in Result { try transform(from) } }) }
}
