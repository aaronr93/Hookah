//
//  Hookah.swift
//  Hookah
//
//  Created by khoi on 1/16/16.
//  Copyright © 2016 Khoi Lai. All rights reserved.
//

import Foundation

public class Hookah {
    /**
     Get the first element of a collection.
     
     - parameter array: The collection to query.
     
     - returns: The first element of collection or nil.
     */
    public class func first<T>(collection: T) -> T.Iterator.Element? where T: Collection, T.Index == Int{
        return head(collection: collection)
    }
    
    /**
     Get the first element of a collection. Alias: first
     
     - parameter array: The collection to query.
     
     - returns: The first element of collection or nil.
     */
    
    public class func head<T>(collection: T) -> T.Iterator.Element? where T: Collection, T.Index == Int{
        return collection.isEmpty ? nil : collection.first
    }
    
    /**
     Get the last element of a collection.
     
     - parameter array: The collection to query.
     
     - returns: The last element of the collection or nil.
     */
    public class func last<T>(collection: T) -> T.Iterator.Element? where T: Collection {
        let index = collection.index(collection.endIndex, offsetBy: -1)
        return collection.isEmpty ? nil : collection[index]
    }
    
    /**
     Iterates over elements of collection invoking iteratee function on each element. Alias: forEach
     
     - parameter collection: The collection to iterate over.
     - parameter iteratee:   The function invoked per iteration.
     */
    public class func each<T>(collection: T, iteratee: (T.Iterator.Element) throws -> ()) rethrows where T: Collection{
        for element in collection{
            try iteratee(element)
        }
    }
    
    /**
     Iterates over elements of collection invoking iteratee function on each element.
     
     - parameter collection: The collection to iterate over.
     - parameter iteratee:   The function invoked per iteration.
     */
    public class func forEach<T>(collection: T, iteratee: (T.Iterator.Element) throws -> ()) rethrows where T: Collection{
        try each(collection: collection, iteratee: iteratee)
    }
    
    /**
     This is like Hookah.each except that it iterates over elements of collection from right to left. Alias: forEachRight
     
     - parameter collection: The collection to iterate over.
     - parameter iteratee:   The function invoked per iteration.
     */
    public class func eachRight<T>(collection: T, iteratee: (T.Iterator.Element) throws -> ()) rethrows where T: Collection, T.Index == Int{
        var length = Int(collection.count);
        repeat{
            length -= 1
            try iteratee(collection[length])
        } while length > 0
        
    }
    
    /**
     This is like Hookah.each except that it iterates over elements of collection from right to left.
     
     - parameter collection: The collection to iterate over.
     - parameter iteratee:   The function invoked per iteration.
     */
    public class func forEachRight<T>(collection: T, iteratee: (T.Iterator.Element) throws -> ()) rethrows where T: Collection, T.Index == Int{
        try eachRight(collection: collection, iteratee: iteratee)
    }
    
    /**
     Creates an array of values by running each element in collection through a transform function.
     
     - parameter collection: The collection to be transformed.
     - parameter transform:  The function invoked on each element of the collection.
     
     - throws: An error if transform encounters an error.
     
     - returns: The new mapped array.
     */
    public class func map<T: Collection, E>(collection: T,transform: (T.Iterator.Element) throws -> E ) rethrows -> [E]{
        var result = [E]()
        try each(collection: collection){
            result.append(try transform($0))
        }
        return result
    }
    
    /**
     Iterates over elements of collection, returning an array of all elements predicate returns true for.
     
     - parameter collection: The collection to iterate over.
     - parameter predicate:  The function invoked per iteration.
     
     - throws: An error if predicate encounters an error.
     
     - returns: Returns the new filtered array.
     */
    public class func filter<T>(collection: T,predicate: (T.Iterator.Element) throws -> Bool) rethrows -> [T.Iterator.Element] where T: Collection{
        var result : [T.Iterator.Element] = []
        try each(collection: collection){
            if try predicate($0){
                result.append($0)
            }
        }
        return result
    }
    
    /**
     Return true if value is presented in the collection. Alias: includes
     
     - parameter collection: The collection to check.
     - parameter value:      The value to check.
     
     - returns: Boolean determined whether the value is presented.s
     */
    public class func contains<T>(collection: T, value: T.Iterator.Element) -> Bool where T: Collection, T.Iterator.Element: Equatable{
        return collection.contains(value)
    }
    
    /**
     Return true if value is presented in the collection.
     
     - parameter collection: The collection to check.
     - parameter value:      The value to check.
     
     - returns: Boolean determined whether the value is presented.
     */
    public class func includes<T>(collection: T, value: T.Iterator.Element) -> Bool where T: Collection, T.Iterator.Element: Equatable{
        return collection.contains(value)
    }
    
    /**
     Checks if predicate returns true for all elements of collection. Iteration is stopped once predicate returns falsey.
     
     - parameter collection: The collection to iterate over.
     - parameter predicate:  The function invoked per iteration.
     
     - throws: An error if predicate encounters an error.
     
     - returns: Returns true if all elements pass the predicate check, else false.
     */
    public class func every<T>(collection: T,predicate: (T.Iterator.Element) throws -> Bool) rethrows -> Bool where T: Collection{
        for element in collection{
            if try predicate(element) == false {
                return false
            }
        }
        return true
    }
    
    /**
     Checks if predicate returns true for ANY element of collection. Iteration is stopped once predicate returns true.
     
     - parameter collection: The collection to iterate over.
     - parameter predicate:  The function invoked per iteration.
     
     - throws: An error if predicate encounters an error.
     
     - returns: Returns true if any element passes the predicate check, else false.
     */
    public class func some<T>(collection: T,predicate: (T.Iterator.Element) throws -> Bool) rethrows -> Bool where T: Collection{
        for element in collection{
            if try predicate(element) == true {
                return true
            }
        }
        return false
    }
    
    /**
     Iterates over elements of collection, returning the first element predicate returns true for.
     
     - parameter collection: The collection to iterate over.
     - parameter predicate:  The function invoked per iteration.
     
     - throws: An error if predicate encounters an error.
     
     - returns: Returns the matched element, else nil.
     */
    public class func find<T>(collection: T, predicate: (T.Iterator.Element) throws -> Bool) rethrows -> T.Iterator.Element? where T: Collection {
        
        for element in collection {
            if try predicate(element) == true {
                return element
            }
        }
        return nil
    }
    
    /**
     This is like Hookah.find except it iterates over the elements of the collection from right to left
     
     - parameter collection: The collection to iterate over.
     - parameter predicate:  The function invoked per iteration.
     
     - throws: An error if predicate encounters an error.
     
     - returns: Returns the matched element, else nil.
     */
    public class func findLast<T>(collection: T,predicate: (T.Iterator.Element) throws -> Bool) rethrows -> T.Iterator.Element? where T: Collection, T.Index == Int{
        var length = Int(collection.count);
        repeat{
            length -= 1
            if try predicate(collection[length]) == true{
                return collection[length]
            }
        } while length > 0
        return nil
    }
    
    /**
     Create a dictionary where the key is a string got by run iteratee through the element, and the value is the arrays of the elements responsible for getting that key
     
     - parameter collection: The collection to iterate over.
     - parameter iteratee:   The iteratee invoked per element.
     
     - throws: An error if iteratee encounters an error.
     
     - returns: Returns the dictionary [String: [T]]
     */
    public class func groupBy<T>(collection: T, iteratee: (T.Iterator.Element) throws -> String) rethrows -> [String: [T.Iterator.Element]] where T: Collection{
        var result : [String: [T.Iterator.Element]] = Dictionary()
        try each(collection: collection){
            let key = try iteratee($0)
            result[key] == nil ? result[key] = [$0] : result[key]?.append($0)
        }
        return result
    }
    
    /**
     Reduces collection to a value which is the accumulated result of running each element in collection through iteratee, where each successive invocation is supplied the return value of the previous.
     
     - parameter collection: The collection to iterate over.
     - parameter initial:    The initial value.
     - parameter combine:    The function invoked per iteration
     
     - throws: An error if combiner encounters an error.
     
     - returns: Returns the accumulated value.
     */
    public class func reduce<T,E>(collection: T,initial: E,  combine: (E, T.Iterator.Element) throws -> E) rethrows -> E where T: Collection{
        var current = initial
        try each(collection: collection){
            current = try combine(current, $0)
        }
        return current
    }
    
    /**
     This method is like Hookah.reduce except that it iterates over elements of collection from right to left.
     
     - parameter collection: The collection to iterate over.
     - parameter initial:    The initial value.
     - parameter combine:    The function invoked per iteration
     
     - throws: An error if combiner encounters an error.
     
     - returns: Returns the accumulated value.
     */
    public class func reduceRight<T,E>(collection: T,initial: E,  combine: (E, T.Iterator.Element) throws -> E) rethrows -> E where T: Collection, T.Index == Int{
        var current = initial
        try eachRight(collection: collection){
            current = try combine(current, $0)
        }
        return current
    }
    
    /**
     The opposite of Hookah.filter; this method returns the elements of collection that predicate does not return true for.
     
     - parameter collection: The collection to iterate over.
     - parameter predicate:  The function invoked per iteration
     
     - throws: An error if predicate encounters an error.
     
     - returns: Returns the new filtered array.
     */
    public class func reject<T>(collection: T, predicate: (T.Iterator.Element) throws -> Bool) rethrows -> [T.Iterator.Element] where T: Collection{
        return try filter(collection: collection, predicate: { try !predicate($0) })
    }
    
    /**
     Gets a random element from collection.
     
     - parameter collection: The collection to sample.
     
     - returns: The random element.
     */
    public class func sample<T>(collection: T) -> T.Iterator.Element where T: Collection, T.Index == Int{
        return collection[Hookah.random(lower: 0, upper: Int(collection.count - 1))]
    }
    
    /**
     Gets n random elements from collection.
     
     Using [Fisher-Yates shuffle](http://en.wikipedia.org/wiki/Fisher–Yates_shuffle).
     
     - parameter collection: The collection to sample.
     - parameter n:          The number of elements to sample. 0 by default.
     
     - returns: Array of random elements
     */
    public class func sampleSize<T>(collection: T, n: Int) -> [T.Iterator.Element] where T: Collection, T.Index == Int{
        let length = collection.count
        let number = max(min(n, Int(length)), 0)
        let result = shuffle(collection: collection)
        return slice(array: result, start: 0, end: number)
    }
    
    
    /**
     Creates an array of shuffled values.
     
     Using [Fisher-Yates shuffle](http://en.wikipedia.org/wiki/Fisher–Yates_shuffle).
     
     - parameter collection: The collection to shuffle.
     
     - returns: Returns the shuffled array.
     */
    public class func shuffle<T>(collection: T) -> [T.Iterator.Element] where T: Collection, T.Index == Int{
        var result : [T.Iterator.Element] = Array(collection)
        let length = Int(collection.count)
        for i in 0..<length{
            let j = Int(arc4random_uniform(UInt32(length - i))) + i
            let temp = result[i]
            result[i] = result[j]
            result[j] = temp
        }
        return result
    }
    
    /**
     Return the size of collection.
     
     Complexity: O(1) in most cases. O(n) in worst cases.
     
     - parameter collection: The collection.
     
     - returns: The collection size.
     */
    public class func size<T>(collection: T) -> Int where T: Collection{
        if let count = collection.count as? Int {
            return count
        } else {
            var size = 0
            for _ in collection {
                size += 1
            }
            return size
        }
    }
    
    
}

