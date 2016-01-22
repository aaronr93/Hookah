//
//  Array.swift
//  Hookah
//
//  Created by khoi on 1/20/16.
//  Copyright © 2016 Khoi Lai. All rights reserved.
//

import Foundation

extension Hookah{
    
    /**
     Create an array by slicing the array from start up to, but not including, end.
     
     - parameter array: The array to slice.
     - parameter start: The start position.
     - parameter end:   The end position. `nil` by default.
     
     - returns: The sliced array
     */
    public class func slice<T>(array: [T], start: Int, end: Int? = nil) -> [T]{
        var end = end ?? array.count
        if end > array.count {
            end = array.count
        }
        if start > array.count || start > end{
            return []
        } else {
            return Array(array[start..<end])
        }
    }
    
    
    /**
     Create an array with all nil values removed.
     
     - parameter array: The array to compact.
     
     - returns: The new filtered array.
     */
    public class func compact<T>(array: [T?]) -> [T]{
        var result = [T]()
        for elem in array{
            if let value = elem{
                result.append(value)
            }
        }
        return result
    }
    
    /**
     Create an array of elements split in to groups by the length of size. If array can't be split evenly, the final chunk contains all the remain elements.
     
     - parameter array: The array to process.
     - parameter size:  The length of each chunk. 0 by default.
     
     - returns: The new array contains chunks
     */
    public class func chunk<T>(array: [T], size: Int = 0) -> [[T]]{
        var result = [[T]]()
        if size < 1 {
            return result
        }
        let length = array.count
        var i = 0
        while (i < length){
            let start = i
            i += size
            result.append(slice(array, start: start, end: i))
        }
        return result
    }
    
    /**
     Creates a new array concatenating additional values.
     
     - parameter array:  The array to concatenate.
     - parameter values: The values to concatenate.
     
     - returns: The new concatenated array.
     */
    public class func concat<T>(array: [T], values: T...) -> [T]{
        var result = Array(array)
        result.appendContentsOf(values)
        return result
    }
    
    /**
     Creates a new array concatenating additional arrays.
     
     - parameter array:  The array to concatenate.
     - parameter arrays: The arrays to concatenate.
     
     - returns: The new concatenated array.
     */
    public class func concat<T>(array: [T], arrays: [T]...) -> [T]{
        var result = Array(array)
        for arr in arrays{
            result.appendContentsOf(arr)
        }
        return result
    }
    
    
    private class func _baseFlatten<T>(array: [T], isDeep:Bool = false) -> [T] {
        var result = [T]()
        for element in array {
            if let val = element as? [T] {
                if isDeep {
                    result += _baseFlatten(val, isDeep:true)
                } else {
                    result += val
                }
            } else {
                result.append(element)
            }
        }
        
        return result
    }
    
    /**
     Flatten array one level.
     
     - parameter array: The array to flatten.
     
     - returns: The new flattened array.
     */
    public class func flatten<T>(array: [T]) -> [T] {
        return _baseFlatten(array)
    }
    
    /**
     This method is like Hookah.flatten except that it recursively flattens array.
     
     - parameter array: The array to flatten.
     
     - returns: The new flattened array.
     */
    public class func flattenDeep<T>(array: [T]) -> [T]{
        return _baseFlatten(array, isDeep:true)
    }
    
    /**
     Creates a slice of array with n elements dropped from the beginning.
     
     - parameter array: The array to query.
     - parameter n:     The number of elements to drop.
     
     - returns: Returns the slice of array.
     */
    public class func drop<T>(array: [T], n: Int = 1) -> [T]{
        return slice(array, start: n < 0 ? 0 : n, end: array.count)
    }
    
    /**
     Creates a slice of array with n elements dropped from the end.
     
     - parameter array: The array to query.
     - parameter n:     The number of elements to drop.
     
     - returns: Returns the slice of array.
     */
    public class func dropRight<T>(array: [T], n: Int = 1) -> [T]{
        let end = array.count - n
        return slice(array, start: 0, end: end < 0 ? 0 : end)
    }
    
    private class func baseWhile<T>(array: [T], predicate: T -> Bool, isDrop: Bool = false, fromRight: Bool = false) -> [T]{
        let length = array.count
        var index = fromRight ? length : -1
        while (fromRight ? --index > 0 : ++index < length) && predicate(array[index]){}
        return isDrop ? slice(array, start: fromRight ? 0 : index, end: fromRight ? index + 1 : length) : slice(array, start: fromRight ? index + 1 : 0, end: fromRight ? length : index)
    }
    
    /**
     Creates a slice of array excluding elements dropped from the beginning. Elements are dropped until predicate returns false.
     
     - parameter array:     The array to query.
     - parameter predicate: The function invoked per iteration.
     
     - returns : Returns the slice of array.
     */
    
    public class func dropWhile<T>(array: [T], predicate: T -> Bool) -> [T]{
        return baseWhile(array, predicate: predicate, isDrop: true, fromRight: false)
    }
    
    /**
     Creates a slice of array excluding elements dropped from the end. Elements are dropped until predicate returns false.
     
     - parameter array:     The array to query.
     - parameter predicate: The function invoked per iteration.
     
     - returns : Returns the slice of array.
     */
    public class func dropRightWhile<T>(array: [T], predicate: T -> Bool) -> [T]{
        return baseWhile(array, predicate: predicate, isDrop: true, fromRight: true)
    }
    
    
    
}
