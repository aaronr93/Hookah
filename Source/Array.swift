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
     Creates an array of unique array values not included in the other provided arrays.
     
     - parameter array:  The array to inspect.
     - parameter values: The values to exclude.
     
     - returns: Returns the new array of filtered values.
     */
    public class func difference<T where T:Equatable>(array:[T], values:[T])-> [T] {
        return _baseDifference(array, values: values, comparator:==)
    }
    
    /**
     This method is like Hookah.difference except that it accepts iteratee which is invoked for each element of array and values to generate the criterion by which uniqueness is computed.
     
     - parameter array:    The array to inspect.
     - parameter values:   The values to exclude.
     - parameter iteratee: The iteratee invoked per element.
     
     - returns: Returns the new array of filtered values.
     */
    public class func differenceBy<T where T:Equatable>(array:[T], values:[T], iteratee:(T->T)) -> [T] {
        return _baseDifference(array, values: values, comparator:==, iteratee:iteratee)
    }
    
    /**
     This method is like Hookah.difference except that it accepts comparator which is invoked to compare elements of array to values.
     
     - parameter array:      The array to inspect.
     - parameter values:     The values to exclude.
     - parameter comparator: The comparator invoked per element.
     
     - returns: Returns the new array of filtered values.
     */
    public class func differenceWith<T>(array:[T], values:[T], comparator:((T,T)->Bool)) -> [T] {
        return _baseDifference(array, values: values, comparator: comparator)
    }
    
    private class func _baseDifference<T>(array:[T], values:[T], comparator:((T,T)->Bool), iteratee:(T->T)?=nil) -> [T] {
        var result = [T]()
        for elem1 in array {
            var isUnique = true
            let val1 = iteratee != nil ? iteratee!(elem1) : elem1
            
            for elem2 in values {
                let val2 = iteratee != nil ? iteratee!(elem2) : elem2

                if comparator(val1, val2) {
                    isUnique = false
                    break
                }
            }
            
            if isUnique {
                result.append(elem1)
            }
        }
        
        return result
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
     Creates an array of flattened values by running each element in array through iteratee and concating its result to the other mapped values.
     
     - parameter array:    The array to iterate over.
     - parameter iteratee: The function invoked per iteration.
     
     - returns: Returns the new array.
     */
    public class func flatMap<T>(array:[T], iteratee:T->[T]) -> [T] {
        var result = [T]()
        for elem in array {
            result.appendContentsOf(iteratee(elem))
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
     Gets the index at which the first occurrence of value is found in array.
     
     - parameter array:     The array to search.
     - parameter value:     The value to search for.
     - parameter fromIndex: The index to search from. `nil` by default
     
     - returns:  Returns the index of the matched value, else `nil`.
     */
    //TODO: If the array is sorted using binary search instead
    public class func indexOf<T where T:Equatable>(array:[T], value:T, fromIndex:UInt?=nil) -> Int? {
        let fromIdx = fromIndex ?? 0
        guard Int(fromIdx) < array.count else {return nil}
        for i in Int(fromIdx)..<array.count {
            if array[i] == value {
                return i
            }
        }
        return nil
    }
    
    /**
     Gets all but the last element of array.
     
     - parameter array: The array to query.
     
     - returns: Returns the slice of array.
     */
    public class func initial<T>(array:[T]) -> [T] {
        return slice(array, start: 0, end: array.count-1)
    }
    
    /**
     Creates an array of unique values that are included in all of the provided arrays.
     
     - parameter arrays: The arrays to inspect.
     
     - returns: Returns the new array of shared values.
     */
    public class func intersection<T where T:Equatable>(arrays:[T]...) -> [T] {
        return _baseIntersection(Array(arrays), comparator:==)
    }
    
    /**
     This method is like Hookah.intersection except that it accepts iteratee which is invoked for each element of each arrays to generate the criterion by which uniqueness is computed.
     
     - parameter arrays:   The arrays to inspect.
     - parameter iteratee: The iteratee invoked per element.
     
     - returns: Returns the new array of shared values.
     */
    public class func intersectionBy<T where T:Equatable>(arrays:[T]..., iteratee:T->T) -> [T] {
        return _baseIntersection(Array(arrays), comparator:==, iteratee:iteratee)
    }
    
    /**
     This method is like Hookah.intersection except that it accepts comparator which is invoked to compare elements of arrays.
     
     - parameter arrays:     The arrays to inspect.
     - parameter comparator: The comparator invoked per element.
     
     - returns: Returns the new array of shared values.
     */
    public class func intersectionWith<T>(arrays:[T]..., comparator:(T,T)->Bool) -> [T] {
        return _baseIntersection(Array(arrays), comparator: comparator)
    }
    
    public class func join(array:[String], separator:String=",") -> String {
//        Hookah.reduce(array.enumerate(), initial: <#T##E#>, combine: <#T##(E, T.Generator.Element) throws -> E#>)
//        return array.reduce("", combine: {$0 + $1.element})

        
//        return Hookah.reduce(array.enumerate(), initial: "", combine: {$0 + $1.element + ($1.index < array.endIndex-1 ? separator : "")})
        // TODO:
        return ""
    }
    
    public class func _baseIntersection<T>(arrays:[[T]], comparator:(T,T)->Bool, iteratee:(T->T)?=nil) -> [T] {
        guard arrays.count > 0 else {return []}
        guard arrays.count > 1 else {return arrays[0]}
        
        var result = arrays[0]
        for i in 1..<arrays.count {
            var tmp = [T]()
            for elem1 in result {
                var isCommonElem = false
                let val1 = iteratee != nil ? iteratee!(elem1) : elem1
                for elem2 in arrays[i] {
                    let val2 = iteratee != nil ? iteratee!(elem2) : elem2
                    if comparator(val1, val2) {
                        isCommonElem = true
                        break
                    }
                }
                if isCommonElem {
                    tmp.append(elem1)
                }
            }
            result = tmp
            if result.count == 0 {break}
        }
        
        return result
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
    
    private class func baseWhile<T>(array: [T], predicate: (T -> Bool), isDrop: Bool = false, fromRight: Bool = false) -> [T]{
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
    
    /**
     Fill elements of array in indexes with value.
     
     Note: This method mutates array
     
     - parameter array:   The pointer of the array to fill.
     - parameter value:   The value to fill the array with
     - parameter indexes: The indexes that the value will be filled.
     */
    public class func fill<T>(inout array: [T], value: T, indexes: [Int]){
        indexes.forEach { (idx) -> () in
            if case 0..<array.count = idx {
                array[idx] = value
            }
        }
    }
    
    /**
     Fill elements of array with value from start upto, but not including end.
     
     - parameter array: The pointer of the array to fill.
     - parameter value: The value to fill the array with.
     - parameter start: The start position. `0` by default.
     - parameter end:   The end position. `nil` by default.
     */
    public class func fill<T>(inout array: [T], value: T, start: Int = 0, end: Int? = nil) {
        var end = end ?? array.count
        if end > array.count {
            end = array.count
        }
        let indexes = Array<Int>(start..<(start + end))
        self.fill(&array, value: value, indexes: indexes)
    }
    
    private class func baseFindIndex<T>(array: [T], fromRight: Bool = false, predicate: T -> Bool) -> Int{
        let length = array.count
        var index = fromRight ? length : -1;
        while fromRight ? index-- > 0 : ++index < length {
            if predicate(array[index])  {
                return index;
            }
        }
        return -1;
    }
    
    /**
     This method is like Hookah.find except that it returns the index of the first element predicate returns true for instead of the element itself.
     
     - parameter array:     The array to search.
     - parameter predicate: The function invoked per iteration.
     
     - returns: Returns the index of the found element, else -1.
     */
    public class func findIndex<T>(array: [T], predicate: T -> Bool) -> Int{
        return baseFindIndex(array, fromRight: false, predicate: predicate)
    }
    
    /**
     This method is like Hookah.findIndex except that it iterates over elements of array from right to left.
     
     - parameter array:     The array to search.
     - parameter predicate: The function invoked per iteration.
     
     - returns: Returns the index of the found element, else -1.
     */
    public class func findLastIndex<T>(array: [T], predicate: T -> Bool) -> Int{
        return baseFindIndex(array, fromRight: true, predicate: predicate)
    }
    
    enum XorType {
        case Normal
        case By
        case With
    }
    
    /**
     Creates an array of unique values that is the symmetric difference of the provided arrays.
     
     - parameter arrays: The arrays to inspect.
     
     - returns: Returns the new array of values.
     */
    public class func xor<T where T:Equatable>(arrays:[T]...) -> [T] {
        return _baseXor(arrays, isXorBy: false, comparator:==)
    }

    public class func xorBy<T where T:Equatable>(arrays:[T]..., iteratee:(T->T)) -> [T] {
        return _baseXor(arrays, isXorBy: true, comparator: ==, iteratee: iteratee)
    }
    
    public class func xorWith<T>(arrays:[T]..., comparator:(T,T)->Bool) -> [T] {
        return _baseXor(arrays, isXorBy:false, comparator:comparator)
    }
    
    private class func _baseXor<T>(arrays:[[T]], isXorBy:Bool, comparator:(T,T)->Bool, iteratee:(T->T)?=nil) -> [T] {
        guard arrays.count > 0 else {return []}
        guard arrays.count > 1 else {return arrays[0]}
        
        var result = arrays[arrays.count-1]
        
        for i in (0...arrays.count-2).reverse() {
            let nextArr = arrays[i]
            print(nextArr)
            var tmp = [T]()
            var uniqueElemMarker = [Bool](count: result.count, repeatedValue: true)
            
            for elem1 in nextArr {
                var isUnique = true
                for j in 0..<result.count {
                    let elem2 = result[j]
                    if isXorBy {
                        if let iteratee = iteratee {
                            if comparator(iteratee(elem1), iteratee(elem2)) {
                                isUnique = false
                                uniqueElemMarker[j] = false
                                break
                            } else {
                                continue
                            }
                        }
                    }
                    
                    if comparator(elem1, elem2) {
                        isUnique = false
                        uniqueElemMarker[j] = false
                        break
                    }
                }
                
                if isUnique {
                    tmp.append(elem1)
                }
            }
            
            for i in 0..<result.count {
                if uniqueElemMarker[i] {
                    tmp.append(result[i])
                }
            }
            
            result = tmp
        }
        
        return result
    }
}
