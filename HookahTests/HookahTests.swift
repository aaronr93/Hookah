//
//  HookahTests.swift
//  HookahTests
//
//  Created by khoi on 1/16/16.
//  Copyright © 2016 Khoi Lai. All rights reserved.
//

import XCTest
@testable import Hookah

class HookahTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFirst() {
        
        if let result = Hookah.first(collection: [1, 2, 3, 4, 5, 6]) {
            XCTAssertEqual(result, 1)
        }
        XCTAssertNil(Hookah.first(collection: [Int]()))
        
    }
    
    func testHead() {
        
        if let result = Hookah.head(collection: [1, 2, 3, 4, 5, 6]) {
            XCTAssertEqual(result, 1)
        }
        XCTAssertNil(Hookah.head(collection: [Int]()))
        
    }
    
    
    func testLast(){
        if let result = Hookah.last(collection: [1, 2, 3, 4, 5, 6]) {
            XCTAssertEqual(result, 6)
        }
        XCTAssertNil(Hookah.last(collection: [Int]()))
        
    }
    
    func testInclude(){
        XCTAssertEqual(Hookah.includes(collection: [1,2,3,4,5], value: 5), true, "Should include")
        XCTAssertEqual(!Hookah.includes(collection: [1,2,3,4,5], value: 10), true, "Should include")
        
    }
    
    func testSlice() {
        XCTAssertEqual(Hookah.slice(array: [1,2,3,4,5], start: 0, end: 2), [1, 2])
        XCTAssertEqual(Hookah.slice(array: [1,2,3,4,5], start: 0), [1, 2, 3, 4, 5])
        XCTAssertEqual(Hookah.slice(array: [1,2,3,4,5], start: 3), [4, 5])
        XCTAssertEqual(Hookah.slice(array: [1,2,3,4,5], start: 8), [])
        XCTAssertEqual(Hookah.slice(array: [1,2,3,4,5], start: 8, end: 10), [])
        XCTAssertEqual(Hookah.slice(array: [1,2,3,4,5], start: 1, end: 1), [])
        XCTAssertEqual(Hookah.slice(array: [1,2,3,4,5], start: 8 , end: 2), [])
        XCTAssertEqual(Hookah.slice(array: [1,2,3,4,5], start: 3, end: 3), [])
        XCTAssertEqual(Hookah.slice(array: [1,2,3,4,5], start: 2, end: 5), [3,4,5])
        XCTAssertEqual(Hookah.slice(array: [1,2,3,4,5], start: 0, end: 9), [1,2,3,4,5])
    }
    
    func testMap(){
        let doubleArray = Hookah.map(collection: [1,2,3,4,5]) { $0 * 2 }
        let arrayString = Hookah.map(collection: ["a","b","c"]) { "Hello \($0)" }
        XCTAssertEqual(doubleArray, [2,4,6,8,10], "Double the array")
        XCTAssertEqual(arrayString, ["Hello a","Hello b","Hello c"], "Append string to the array")
        
    }
    
    func testCompact(){
        XCTAssertEqual(Hookah.compact(array: [2,3,4,nil,6,7]), [2,3,4,6,7])
    }
    
    func testChunk(){
        XCTAssert(Hookah.chunk(array: [] as [NSObject], size: 2).isEmpty, "chunk for empty array returns an empty array")
        XCTAssert(Hookah.chunk(array: [1, 2, 3],size: 0).isEmpty, "chunk into parts of 0 elements returns empty array")
        XCTAssert(Hookah.chunk(array: [1, 2, 3],size: -1).isEmpty, "chunk into parts of negative amount of elements returns an empty array")
        XCTAssert(Hookah.chunk(array: [1, 2, 3]).isEmpty, "defaults to empty array (chunk size 0)")
        let test1 = Hookah.chunk(array: [1, 2, 3], size: 1)
        XCTAssert(test1.count == 3 && test1[0][0] == 1 && test1[1][0] == 2 && test1[2][0] == 3, "chunk into parts of 1 elements returns original array")
        let test2 = Hookah.chunk(array: [1, 2, 3], size: 3)
        XCTAssert(test2.count == 1 && test2[0] == [1, 2, 3], "chunk into parts of current array length elements returns original array")
        let test3 = Hookah.chunk(array: [1, 2, 3], size: 5)
        XCTAssert(test3.count == 1 && test3[0] == [1, 2, 3], "chunk into parts of more then current array length elements returns the original array")
        let test4 = Hookah.chunk(array: [10, 20, 30, 40, 50, 60, 70], size: 2)
        XCTAssert(test4.count == 4 && test4[0].count == 2 && test4[1].count == 2 && test4[2].count == 2 && test4[3].count == 1 &&
            test4[0][0] == 10 && test4[0][1] == 20 && test4[1][0] == 30 && test4[1][1] == 40 &&
            test4[2][0] == 50 && test4[2][1] == 60 && test4[3][0] == 70, "chunk into parts of less then current array length elements")
        //[[10, 20], [30, 40], [50, 60], [70]]
        let test5 = Hookah.chunk(array: [10, 20, 30, 40, 50, 60, 70], size: 3)
        XCTAssert(test5.count == 3 && test5[0].count == 3 && test5[1].count == 3 && test5[2].count == 1 &&
            test5[0][0] == 10 && test5[0][1] == 20 && test5[0][2] == 30 &&
            test5[1][0] == 40 && test5[1][1] == 50 && test5[1][2] == 60 && test5[2][0] == 70, "chunk into parts of less then current array length elements")
        //[[10, 20, 30], [40, 50, 60], [70]]
    }
    
    func testConcat(){
        let array = [1]
        XCTAssertEqual(Hookah.concat(array: array, arrays: [2], [3], [4]), [1,2,3,4], "Should concat values")
        XCTAssertEqual(Hookah.concat(array: array, arrays: [1,2],[3,4],[0]), [1,1,2,3,4,0], "Should concat arrays")
    }
    
    func testContains(){
        let arrayString = ["asd","test","123"]
        let arrayNumber = [1,2,3,4,5]
        XCTAssert(Hookah.contains(collection: arrayString, value: "asd"), "Should contain string")
        XCTAssert(!Hookah.contains(collection: arrayString, value: "3"), "Should NOT contain string")
        XCTAssert(Hookah.contains(collection: arrayNumber, value: 4), "Should contain number")
        XCTAssert(!Hookah.contains(collection: arrayNumber, value: 40), "Should NOT contain number")
    }
    
    func testFilter(){
        let arr = [1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(Hookah.filter(collection: arr){ $0 % 2 == 0 }, [2,4,6,8], "Even array")
    }
    
    func testEvery(){
        XCTAssert(Hookah.every(collection: [true, true, true], predicate: { $0 == true }), "every true values")
        XCTAssert(!Hookah.every(collection: [true, false, true], predicate: { $0 == true }), "one false value")
        XCTAssert(Hookah.every(collection: [0, 10, 28], predicate: { $0 % 2 == 0 }), "even numbers")
        XCTAssert(!Hookah.every(collection: [0, 11, 28], predicate: { $0 % 2 == 0 }), "an odd number")
    }
    
    func testSome(){
        XCTAssert(Hookah.some(collection: [true, false, true], predicate: { $0 == true }), "one false value")
        XCTAssert(!Hookah.some(collection: [false, false, false], predicate: { $0 == true }), "all true value")
        XCTAssert(Hookah.some(collection: [11, 10, 22], predicate: { $0 % 2 == 0 }), "even numbers")
        XCTAssert(!Hookah.some(collection: [3, 11, 25], predicate: { $0 % 2 == 0 }), "an odd number")
        
    }
    
    func testFind(){
        let array = [1, 2, 3, 4]
        XCTAssertEqual(Hookah.find(collection: array){ $0 % 2 == 0 }, 2, "Should return the first founded value")
        XCTAssertEqual(Hookah.find(collection: array){ $0 == 3 }, 3, "Should return the first founded value")
        XCTAssertEqual(Hookah.find(collection: array){ $0 == 0 }, nil, "Should return nil when value not found")
    }
    
    func testFindLast(){
        let array = [1, 2, 3, 4]
        XCTAssertEqual(Hookah.findLast(collection: ["a","b","c"]) { (element) -> Bool in element == "c" }, "c", "Should return the last value that matches the predicate")
        XCTAssertEqual(Hookah.findLast(collection: array){ $0 % 2 == 0 }, 4, "Should return the last founded value")
        XCTAssertEqual(Hookah.findLast(collection: array){ $0 == 3 }, 3, "Should return the last founded value")
        XCTAssertEqual(Hookah.findLast(collection: array){ $0 == 0 }, nil, "Should return nil when value not found")
    }
    
    func testGroupBy(){
        let arr = [1,2,3,4,5]
        let test = Hookah.groupBy(collection: arr){ $0 % 2 == 0 ? "even" : "odd" }
        XCTAssertEqual(test["even"]!, [2,4], "SHould have even group")
        XCTAssertEqual(test["odd"]!, [1,3,5], "SHould have odd group")
    }
    
    func testReduce(){
        let arr = [1,2,3,4,5]
        XCTAssertEqual(Hookah.reduce(collection: arr, initial: 0, combine: +), 15, "Should sum up value")
        XCTAssertEqual(Hookah.reduce(collection: arr, initial: 1, combine: +), 16, "Should sum up value using default value")
        XCTAssertEqual(Hookah.reduce(collection: arr, initial: 1, combine: *), 120, "Should multiplied up value")
        let test = Hookah.reduce(collection: ["foo","bar","baz"], initial: "") {return "\($0)\($1)" }
        XCTAssert(test == "foobarbaz", "Should combine string")
    }
    
    func testReduceRight(){
        let arr = [1,2,3,4,5]
        XCTAssertEqual(Hookah.reduceRight(collection: arr, initial: 0, combine: +), 15, "Should sum up value")
        XCTAssertEqual(Hookah.reduceRight(collection: arr, initial: 1, combine: +), 16, "Should sum up value using default value")
        XCTAssertEqual(Hookah.reduceRight(collection: arr, initial: 1, combine: *), 120, "Should multiplied up value")
        let test = Hookah.reduceRight(collection: ["foo","bar","baz"], initial: "") {return "\($0)\($1)" }
        XCTAssertEqual(test, "bazbarfoo", "Should combine string")
        
    }
    
    func testReject(){
        let arr = [1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(Hookah.reject(collection: arr){ $0 % 2 == 0 }, [1,3,5,7,9], "should return odd array")
        
    }
    
    
    
    func testSample(){
        let arr = [1]
        let arr2 = [1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(Hookah.sample(collection: arr), 1, "Should return first sample")
        let sample = Hookah.sample(collection: arr2)
        XCTAssert(Hookah.some(collection: arr2) {  $0 == sample })
        
        
    }
    
    func testSampleSize(){
        let arr = [1]
        let arr2 = [1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(Hookah.sampleSize(collection: arr, n: 1), [1], "Should return first sample")
        XCTAssertEqual(Hookah.sampleSize(collection: arr, n: 0), [], "Should return first sample")
        
        let sampleSize = Hookah.sampleSize(collection: arr2, n: 4)
        XCTAssertEqual(sampleSize.count, 4, "Should pick correct amount of array")
        
        XCTAssert(Hookah.every(collection: sampleSize, predicate: { element in
            Hookah.some(collection: arr2, predicate: { $0 == element })
        }), "Should stop on first iteration")
    }
    
    func testSize(){
        let arr = [1,2,3,4]
        XCTAssertEqual(Hookah.size(collection: arr), 4)
        XCTAssertEqual(Hookah.size(collection: [] as [NSObject]), 0)
        XCTAssertEqual(Hookah.size(collection: ["khoi":1,"toan":2]), 2, "Should return size of array as well")
    }
    
    func testShuffle(){
        let arr = [1,2,3,4,5,6,7,9,8]
        XCTAssert(Hookah.every(collection: arr) { (element) -> Bool in
            Hookah.some(collection: Hookah.shuffle(collection: arr), predicate: { element == $0 })
        }, "Should shuffle the arraay")
    }
    
    func testFlatten(){
        let arr = [1, [2, 3, [4]]] as [Any]
        if let result = Hookah.flatten(array: arr) as? [NSObject] {
            XCTAssertEqual(result, [1 as NSObject, 2 as NSObject, 3 as NSObject, [4] as NSObject], "Should flatten only one level")
        } else {
            XCTFail("Should flatten only one level")
        }
    }
    
    func testFlattenDeep(){
        let arr = [1,2,3,4,5,[6,7],[8],[9]] as [Any]
        if let result = Hookah.flattenDeep(array: arr) as? [Int] {
            XCTAssertEqual(result, [1,2,3,4,5,6,7,8,9], "Should flatten array")
        } else {
            XCTFail("Should flatten array")
        }
        let arr2 = [[1],2,[3,[[4]],5],[[6,7],8],[[9]]] as [Any]
        if let result = Hookah.flattenDeep(array: arr2) as? [Int] {
            XCTAssertEqual(result, [1,2,3,4,5,6,7,8,9], "Should deeply flatten array")
        } else {
            XCTFail("Should deeply flatten array")
        }
    }
    
    
    func testDrop(){
        let array = [1, 2, 3]
        XCTAssertEqual(Hookah.drop(array: array), [2,3], "Should drop first element")
        XCTAssertEqual(Hookah.drop(array: array, n: 2), [3], "should drop more than 1 element")
        XCTAssertEqual(Hookah.drop(array: array, n: 9), [], "Should drop if n > length")
        XCTAssertEqual(Hookah.drop(array: array, n: 0), array, "Should return array if n == 0")
        XCTAssertEqual(Hookah.drop(array: array, n: -1), array, "Should return array if n < 1")
    }
    
    func testDropRight(){
        let array = [1, 2, 3]
        XCTAssertEqual(Hookah.dropRight(array: array), [1,2], "Should drop last element")
        XCTAssertEqual(Hookah.dropRight(array: array, n: 2), [1], "should drop more than 1 element")
        XCTAssertEqual(Hookah.dropRight(array: array, n: 9), [], "Should drop if n > length")
        XCTAssertEqual(Hookah.dropRight(array: array, n: 0), array, "Should return array if n == 0")
        XCTAssertEqual(Hookah.dropRight(array: array, n: -1), array, "Should return array if n < 1")
    }
    
    func testDropWhile(){
        let arr = [1,2,3,4,5]
        XCTAssertEqual(Hookah.dropWhile(array: arr){ $0 < 3 }, [3,4,5], "Should drop elemeent")
    }
    
    func testDropRightWhile(){
        let arr = [1,2,3,4,5]
        XCTAssertEqual(Hookah.dropRightWhile(array: arr){ $0 > 3 }, [1,2,3], "Should drop right elemeent")
    }
    
    func testFillIndexes(){
        var arr = [1,2,3,4]
        
        Hookah.fill(array: &arr, value: 0, indexes: [0])
        XCTAssertEqual(arr, [0,2,3,4], "Should work with 1 index")
        
        Hookah.fill(array: &arr, value: 9, indexes: [2,3])
        XCTAssertEqual(arr, [0,2,9,9], "Should work with multipe indexes")
        
        Hookah.fill(array: &arr, value: 88, indexes: [-3,43,234,-1])
        XCTAssertEqual(arr, [0,2,9,9], "Should work with index out of bound")
    }
    
    func testFill(){
        var array = [1, 2, 3]
        
        Hookah.fill(array: &array, value: 99)
        XCTAssertEqual(array, [99,99,99], "Should fill all values if no start and end defined")
        
        Hookah.fill(array: &array, value: 88, start: 1)
        XCTAssertEqual(array, [99,88,88], "Should work with start")
        
        Hookah.fill(array: &array, value: 100, start: 0, end: 0)
        XCTAssertEqual(array, [99,88,88], "Should work with end = 0")
        
        Hookah.fill(array: &array, value: 100, start: 99, end: 99)
        XCTAssertEqual(array, [99,88,88], "Should work if start is out of bound")
        
        Hookah.fill(array: &array, value: 100, start: 1, end: 3)
        XCTAssertEqual(array, [99,100,100], "Should work if both start and end provide")
        
    }
    
    func testFindIndex(){
        let arr = [1,2,3,4]
        XCTAssertEqual(Hookah.findIndex(array: arr) { $0 % 2 == 0 } , 1, "Should find first number")
        XCTAssertEqual(Hookah.findIndex(array: arr) { $0 > 100 } , -1, "Should return -1 if not found")
    }
    
    func testFindLastIndex(){
        let arr = [1,2,3,4]
        XCTAssertEqual(Hookah.findLastIndex(array: arr) { $0 % 2 == 0 } , 3, "Should find first number")
        XCTAssertEqual(Hookah.findLastIndex(array: arr) { $0 > 100 } , -1, "Should return -1 if not found")
    }
    
    func testRandom() {
        let random = Hookah.random()
        XCTAssert(Hookah.some(collection: [0, 1]) {$0 == random}, "Should return 0 or 1")
        XCTAssertEqual(Hookah.random(lower:2,upper:2), 2, "Should return 2")
    }
    
    func testXor() {
        XCTAssertEqual(Hookah.xor(arrays: [2,1], [4,2]), [1,4], "")
        XCTAssertEqual(Hookah.xor(arrays: [Int]()), [], "")
    }
    
    func testXorBy() {
        XCTAssertEqual(Hookah.xorBy(arrays: [2.1, 1.2], [4.3, 2.4], iteratee: floor), [1.2, 4.3], "")
    }
    
    func compare(obj1:[String:Int], obj2:[String:Int]) -> Bool {
        if obj1["x"] == obj2["x"] && obj1["y"] == obj2["y"] {
            return true
        }
        return false
    }
    
    func testXorWith() {
        let objects1 = [["x":1, "y":2], ["x":2, "y":1]]
        let objects2 = [["x":1, "y":1], ["x":1, "y":2]]
        let test = Hookah.xorWith(arrays: objects1, objects2, comparator: compare)
        XCTAssert(test[0]["x"] == 2 && test[0]["y"] == 1 && test[1]["x"] == 1 && test[1]["y"] == 1, "XorWith failed")
    }
    
    func testDifference() {
        XCTAssertEqual(Hookah.difference(array: [3,2,1], values:[4,2]), [3,1], "")
    }
    
    func testDifferenceBy() {
        XCTAssertEqual(Hookah.differenceBy(array: [3.1, 2.2, 1.3], values: [4.4, 2.5], iteratee: floor), [3.1, 1.3], "")
    }
    
    func testDifferenceWith() {
        let test = Hookah.differenceWith(array: [["x":1,"y":2], ["x":2, "y":1]], values: [["x":1, "y":2]], comparator: compare)
        XCTAssert(test[0]["x"] == 2 && test[0]["y"] == 1, "DifferenceWith failed")
    }
    
    func duplicate(num:Int) -> [Int] {
        return [num, num]
    }
    
    
    func testFlatMap() {
        XCTAssertEqual(Hookah.flatMap(array: [1,2], iteratee:duplicate), [1,1,2,2], "")
    }
    
    func testIndexOf() {
        XCTAssertEqual(Hookah.indexOf(array: [1,2,1,2], value:2), 1, "")
        XCTAssertEqual(Hookah.indexOf(array: [1,2,1,2], value:2, fromIndex:2), 3, "")
        XCTAssertEqual(Hookah.indexOf(array: [1,2,1,2], value:3), nil, "")
        XCTAssertEqual(Hookah.indexOf(array: [1,2,1,2], value:3, fromIndex:10), nil, "")
    }
    
    func testLastIndexOf() {
        XCTAssertEqual(Hookah.lastIndexOf(array: [1,2,1,2], value:2), 3, "")
        XCTAssertEqual(Hookah.lastIndexOf(array: [1,2,1,2], value:2, fromIndex:2), 1, "")
        XCTAssertEqual(Hookah.lastIndexOf(array: [1,2,1,2], value:3), nil, "")
        XCTAssertEqual(Hookah.lastIndexOf(array: [1,2,1,2], value:2, fromIndex:10), 3, "")
    }
    
    func testInitial() {
        XCTAssertEqual(Hookah.initial(array: [1]), [], "")
        XCTAssertEqual(Hookah.initial(array: [Int]()), [], "")
        XCTAssertEqual(Hookah.initial(array: [1,2,3]), [1,2], "")
    }
    
    func testIntersection() {
        XCTAssertEqual(Hookah.intersection(arrays: [2,1], [4,2], [1,2]), [2], "")
        XCTAssertEqual(Hookah.intersection(arrays: [1]), [1], "")
        XCTAssertEqual(Hookah.intersection(arrays: [Int]()), [], "")
    }
    
    func testIntersectionBy() {
        XCTAssertEqual(Hookah.intersectionBy(arrays: [2.1, 1.2], [4.3, 2.4], iteratee:floor), [2.1], "")
    }
    
    func testIntersectionWith() {
        let objects1 = [["x":1, "y":2], ["x":2, "y":1]]
        let objects2 = [["x":1, "y":1], ["x":1, "y":2]]
        let test = Hookah.intersectionWith(arrays: objects1, objects2, comparator: compare)
        XCTAssert(test[0]["x"] == 1 && test[0]["y"] == 2, "Intersection failed")
    }
    
    func testSortedIndex() {
        XCTAssertEqual(Hookah.sortedIndex(array: [], value:40), 0, "")
        XCTAssertEqual(Hookah.sortedIndex(array: [30, 50], value:40), 1, "")
        XCTAssertEqual(Hookah.sortedIndex(array: [4, 5], value:4), 0, "")
        XCTAssertEqual(Hookah.sortedIndex(array: [4, 4, 5], value:4), 0, "")
        XCTAssertEqual(Hookah.sortedIndex(array: [4, 4, 5], value:6), 3, "")
    }
    
    func testSortedIndexBy() {
        //        let iteratee = {dict:[String:Int]->Int in
        //            return dict
        //        }
    }
    
    func testSortedIndexOf() {
        
    }
    
    func testSortedLastIndex() {
        
    }
    
    func testSortedLastIndexBy() {
    }
    
    func testSortedLastIndexOf() {
    }
    
}

