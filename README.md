Hookah [![Build Status](https://travis-ci.org/khoiln/Hookah.svg?branch=master)](https://travis-ci.org/khoiln/Hookah) ![CocoaPods](https://img.shields.io/cocoapods/v/Hookah.svg) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Platform](https://img.shields.io/cocoapods/p/Hookah.svg?style=flat)](http://cocoadocs.org/docsets/Hookah)
===========
Hookah is a functional library for Swift. It's inspired by Lo-Dash project.

# Installation #

## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Hookah into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'Hookah', '~> 0.0.2'
```

Then, run the following command:

```bash
$ pod install
```
## Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "khoiln/Hookah" ~> 0.0.2
```

Run `carthage update` to build the framework and drag the built `Hookah.framework` into your Xcode project.

# API Documentation #

## CollectionType ##

### `Hookah.each` -> `Hookah.forEach`

```swift
Hookah.each<T where T:CollectionType>(collection: T,@noescape iteratee: T.Generator.Element throws -> ()) rethrows
```

```swift
Hookah.each([1,2]){ print($0) }
// → log `1` then `2`

let scores = ["khoi" : 82, "quan" : 40, "toan": 90]
Hookah.each(scores){ print($0.0) }
// -> log `khoi` then `quan` then `toan`
```

Iterates over elements of collection invoking iteratee function on each element.

#### Alias ####
- Hookah.forEach

#### Arguments ####
- collection: The collection to iterate over.
- iteratee:   The function invoked per iteration.

#### Return ####
- Void

### `Hookah.eachRight` -> `Hookah.forEachRight`

```swift
Hookah.eachRight<T where T:CollectionType, T.Index == Int>(collection: T,@noescape iteratee: T.Generator.Element throws -> ()) rethrows
```

```swift
Hookah.eachRight([1,2]){ print($0) }
// → log `2` then `1`
```

This is like Hookah.each except that it iterates over elements of collection from right to left.

#### Alias ####
- Hookah.forEachRight

#### Arguments ####
- collection: The collection to iterate over.
- iteratee:   The function invoked per iteration.

#### Return ####
- Void

### `Hookah.every`

```swift
Hookah.every<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> Bool
```

```swift
Hookah.every([0, 10, 28]){ $0 % 2 == 0 }
// -> true

let scores = ["khoi" : 82, "quan" : 40, "toan": 90]
Hookah.every(scores){ $0.1 > 50 }
// -> false
```

Checks if predicate returns true for all elements of collection. Iteration is stopped once predicate returns false.

#### Arguments ####

- collection: The collection to iterate over.
- iteratee:   The function invoked per iteration.

#### Return ####

Returns true if all elements pass the predicate check, else false.

### `Hookah.filter`

```swift
Hookah.filter<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> [T.Generator.Element]
```

```swift
Hookah.filter([1, 2, 4]){ $0 % 2 == 0 }
// -> [2,4]

let scores = ["khoi" : 82, "quan" : 40, "toan": 90]
Hookah.filter(scores){ $0.1 > 50 }
// -> [("khoi", 82), ("toan", 90)]
```

Iterates over elements of collection, returning an array of all elements predicate returns true for.

#### Arguments ####

- collection: The collection to iterate over.
- predicate:   The function invoked per iteration.

#### Return ####

Returns the new filtered array.

### `Hookah.find`

```swift
Hookah.find<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> T.Generator.Element?
```

```swift
Hookah.find([1, 2, 4]){ $0 % 2 == 0 }
// -> Optional(2)

let scores = ["khoi" : 82, "quan" : 40, "toan": 90]
Hookah.find(scores){ $0.0 == "khoi" }
// -> Optional(("khoi", 82))
```

Iterates over elements of collection, returning the first element predicate returns true for.

#### Arguments ####

- collection: The collection to iterate over.
- predicate:   The function invoked per iteration.

#### Return ####

Returns the matched element, else nil.

### `Hookah.findLast`

```swift
Hookah.findLast<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> T.Generator.Element?
```

```swift
Hookah.findLast([1, 2, 4]){ $0 % 2 == 0 }
// -> 4
```

This is like Hookah.find except it iterates over the elements of the collection from right to left
#### Arguments ####

- collection: The collection to iterate over.
- predicate:   The function invoked per iteration.

#### Return ####

Returns the matched element, else nil.

### `Hookah.groupBy`

```swift
Hookah.groupBy<T where T:CollectionType>(collection: T, @noescape iteratee: T.Generator.Element throws -> String) rethrows -> [String: [T.Generator.Element]]
```

```swift
Hookah.groupBy([1,2,3,4,5]){ $0 % 2 == 0 ? "even" : "odd" }
// -> ["odd": [1, 3, 5], "even": [2, 4]]
```

Create a dictionary where the key is a string got by run iteratee through the element, and the value is the arrays of the elements responsible for getting that key

#### Arguments ####

- collection: The collection to iterate over.
- iteratee:   The iteratee invoked per element.

#### Return ####

Returns the dictionary [String: [T]]

### `Hookah.includes`

```swift
Hookah.includes<T where T: CollectionType, T.Generator.Element: Equatable>(collection: T, value: T.Generator.Element) -> Bool
```

```swift
Hookah.includes([1,2,3,4,5], value: 5)
// -> true
```

Return true if value is presented in the collection.
#### Arguments ####

- collection: The collection to iterate over.
- value:   The value to check.

#### Return ####

Boolean determined whether the value is presented.

### `Hookah.map`

```swift
Hookah.map<T: CollectionType, E>(collection: T,@noescape transform: T.Generator.Element throws -> E ) rethrows -> [E]
```

```swift
func double(a: Int) -> Int{
    return a * 2
}
Hookah.map([1,2,3,4], transform: double)
// -> [2,4,6,8]
```

Creates an array of values by running each element in collection through a transform function.
#### Arguments ####

- collection: The collection to iterate over.
- transform:   The function invoked on each element of the collection.

#### Return ####

The new mapped array.

### `Hookah.reduce`

```swift
Hookah.reduce<T,E where T:CollectionType>(collection: T,initial: E,  @noescape combine: (E, T.Generator.Element) throws -> E) rethrows -> E
```

```swift
Hookah.reduce([1,2,3], initial: 0) { $0 + $1 }
// -> 6
// Thanks for Swift Operator we can do this as well
Hookah.reduce([1,2], initial: 0, combine: +)
// -> 3
```

Reduces collection to a value which is the accumulated result of running each element in collection through iteratee, where each successive invocation is supplied the return value of the previous.
#### Arguments ####

- collection: The collection to iterate over.
- initial:    The initial value.
- combine:    The function invoked per iteration

#### Return ####

Returns the accumulated value.

### `Hookah.reduceRight`

```swift
Hookah.reduceRight<T,E where T:CollectionType>(collection: T,initial: E,  @noescape combine: (E, T.Generator.Element) throws -> E) rethrows -> E
```

```swift
Hookah.reduceRight(["foo","bar","baz"], initial: "") {return "\($0)\($1)" }
// -> "bazbarfoo"
```

This method is like Hookah.reduce except that it iterates over elements of collection from right to left.
#### Arguments ####

- collection: The collection to iterate over.
- initial:    The initial value.
- combine:    The function invoked per iteration

#### Return ####

Returns the accumulated value.

### `Hookah.reject`

```swift
Hookah.reject<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> [T.Generator.Element]
```

```swift
Hookah.reject([1,2,3,4,5]){ $0 % 2 == 0 }
// -> [1,3,5]
let scores = ["khoi" : 82, "quan" : 40, "toan": 90]
Hookah.reject(scores) {$0.1 < 50}
// -> [("khoi", 82), ("toan", 90)]
```

The opposite of Hookah.filter; this method returns the elements of collection that predicate does not return true for.
#### Arguments ####

- collection: The collection to iterate over.
- predicate:  The function invoked per iteration.

#### Return ####

Returns the new filtered array.

### `Hookah.sample`

```swift
Hookah.sample<T where T:CollectionType, T.Index == Int>(collection: T) -> T.Generator.Element
```

```swift
Hookah.sample([1,2,3,4])
// -> 2
```

Gets a random element from collection.
#### Arguments ####

- collection: The collection to sample

#### Return ####

Return the random element.

### `Hookah.sampleSize`

```swift
Hookah.sampleSize<T where T:CollectionType, T.Index == Int>(collection: T, n: Int) -> [T.Generator.Element]
```

```swift
Hookah.sampleSize([1,2,3,4],n: 2)
// -> [2,4]
```

Gets n random elements from collection.

Using [Fisher-Yates shuffle](http://en.wikipedia.org/wiki/Fisher–Yates_shuffle)

#### Arguments ####

- collection: The collection to sample
- n:          The number of elements to sample. 0 by default.

#### Return ####

Array of random elements

### `Hookah.shuffle`

```swift
Hookah.shuffle<T where T:CollectionType, T.Index == Int>(collection: T) -> [T.Generator.Element]
```

```swift
Hookah.shuffle([1,2,3,4])
// -> [2,4,1,3]
```

Creates an array of shuffled values.

Using [Fisher-Yates shuffle](http://en.wikipedia.org/wiki/Fisher–Yates_shuffle).

#### Arguments ####

- collection: The collection to shuffle

#### Return ####

Returns the shuffled array.

### `Hookah.size`

```swift
Hookah.size<T where T:CollectionType>(collection: T) -> Int
```

```swift
Hookah.size([1,2,3,4])
// -> 4
Hookah.size(["khoi":1,"toan":2])
// -> 2
```

Return the size of collection.

Complexity: O(1) in most cases. O(n) in worst cases.

#### Arguments ####

- collection: The collection.

#### Return ####

The collection size.

### `Hookah.some`

```swift
Hookah.some<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> Bool
```

```swift
Hookah.some([11, 10, 22]){ $0 % 2 != 0 }
// -> true
```

Checks if predicate returns true for ANY element of collection. Iteration is stopped once predicate returns true.

#### Arguments ####

- collection: The collection to iterate over.
- predicate: The function invoked per iteration.

#### Return ####

Returns true if any element passes the predicate check, else false.

## Array ##

### `Hookah.chunk`

```swift
Hookah.chunk<T>(array: [T], size: Int = 0) -> [[T]]
```

```swift
Hookah.chunk([1,2,3,4,5],size: 2)
// -> [[1, 2], [3, 4], [5]]
```

Create an array of elements split in to groups by the length of size. If array can't be split evenly, the final chunk contains all the remain elements.

#### Arguments ####

- array: The array to process.
- size: The length of each chunk. 0 by default.

#### Return ####

The new array contains chunks

### `Hookah.compact`

```swift
Hookah.compact<T>(array: [T?]) -> [T]
```

```swift
Hookah.compact([2,3,4,nil,6,7])
// -> [2,3,4,6,7]
```

Create an array with all nil values removed.

#### Arguments ####

- array: The array to compact.

#### Return ####

The new filtered array.

### `Hookah.concat` (values)

```swift
Hookah.concat<T>(array: [T], values: T...) -> [T]
```

```swift
Hookah.concat([1,2,3], values: 2, 3, 4)
// -> [1,2,3,2,3,4]
```

Creates a new array concatenating additional values.

#### Arguments ####

- array: The array to concatenate.
- values: The values to concatenate.

#### Return ####

The new concatenated array.

### `Hookah.concat` (arrays)

```swift
Hookah.concat<T>(array: [T], arrays: [T]...) -> [T]
```

```swift
Hookah.concat(array, arrays: [1,2],[3,4],[0])
// -> [1,1,2,3,4,0]
```

Creates a new array concatenating additional arrays.

#### Arguments ####

- array: The array to concatenate.
- arrays: The arrays to concatenate.

#### Return ####

The new concatenated array.

### `Hookah.difference` 

```swift
Hookah.difference<T where T:Equatable>(array:[T], values:[T])-> [T]
```

```swift
Hookah.difference([3,2,1], values:[4,2])
// -> [3,1]
```

Creates an array of unique array values not included in the other provided arrays.

#### Arguments ####

- array: The array to inspect.
- values: The values to exclude.

#### Return ####

Returns the new array of filtered values.

### `Hookah.differenceBy` 

```swift
Hookah.differenceBy<T where T:Equatable>(array:[T], values:[T], iteratee:(T->T)) -> [T]
```

```swift
Hookah.differenceBy([3.1, 2.2, 1.3], values: [4.4, 2.5], iteratee: floor)
// -> [3.1, 1.3]
```

This method is like Hookah.difference except that it accepts iteratee which is invoked for each element of array and values to generate the criterion by which uniqueness is computed.

#### Arguments ####

- array: The array to inspect.
- values: The values to exclude.
- iteratee: The iteratee invoked per element.

#### Return ####

Returns the new array of filtered values.

### `Hookah.differenceWith` 

```swift
Hookah.differenceWith<T>(array:[T], values:[T], comparator:((T,T)->Bool)) -> [T]
```

```swift
func compare(obj1:[String:Int], obj2:[String:Int]) -> Bool {
    if obj1["x"] == obj2["x"] && obj1["y"] == obj2["y"] {
        return true
    }
    return false;
}
Hookah.differenceWith([["x":1,"y":2], ["x":2, "y":1]], values: [["x":1, "y":2]], comparator: compare)
// -> [["x":2, "y":1]]
```

This method is like Hookah.difference except that it accepts comparator which is invoked to compare elements of array to values.

#### Arguments ####

- array: The array to inspect.
- values: The values to exclude.
- comparator: The comparator invoked per element.

#### Return ####

Returns the new array of filtered values.

### `Hookah.drop`

```swift
Hookah.drop<T>(array: [T], n: Int = 1) -> [T]
```

```swift
Hookah.drop([1, 2, 3])
// -> [2,3]
Hookah.drop([1, 2, 3], n: 2)
// -> [3]
```

Creates a slice of array with n elements dropped from the beginning.

#### Arguments ####

- array: The array to query.
- n: The number of elements to drop. `1` by default.

#### Return ####

Returns the slice of array.

### `Hookah.dropRight`

```swift
Hookah.dropRight<T>(array: [T], n: Int = 1) -> [T]
```

```swift
Hookah.dropRight([1, 2, 3])
// -> [1,2]
Hookah.dropRight([1, 2, 3], n: 2)
// -> [1]
```

Creates a slice of array with n elements dropped from the end.

#### Arguments ####

- array: The array to query.
- n: The number of elements to drop. `1` by default.

#### Return ####

Returns the slice of array.

### `Hookah.dropRightWhile`

```swift
Hookah.dropRightWhile<T>(array: [T], predicate: T -> Bool) -> [T]
```

```swift
Hookah.dropRightWhile([1, 2, 3, 4, 5]){$0 > 3}
// -> [1,2,3]
```

Creates a slice of array excluding elements dropped from the end. Elements are dropped until predicate returns false.

#### Arguments ####

- array: The array to query.
- predicate: The function invoked per iteration.

#### Return ####

Returns the slice of array.

### `Hookah.dropWhile`

```swift
Hookah.dropWhile<T>(array: [T], predicate: T -> Bool) -> [T]
```

```swift
Hookah.dropWhile([1, 2, 3, 4, 5]){$0 < 3}
// -> [3,4,5]
```

Creates a slice of array excluding elements dropped from the beginning. Elements are dropped until predicate returns false.

#### Arguments ####

- array: The array to query.
- predicate: The function invoked per iteration.

#### Return ####

Returns the slice of array.

### `Hookah.flatMap`

```swift
Hookah.flatMap<T>(array:[T], iteratee:T->[T]) -> [T]
```

```swift
func duplicate(num:Int) -> [Int] {
    return [num, num]
}
Hookah.flatMap([1,2], iteratee:duplicate)
// -> [1,1,2,2]
```

Creates an array of flattened values by running each element in array through iteratee and concating its result to the other mapped values.

#### Arguments ####

- array: The array to iterate over.
- iteratee: The function invoked per iteration.

#### Return ####

Returns the new array.

### `Hookah.flatten`

```swift
Hookah.flatten<T>(array: [T]) -> [T]
```

```swift
Hookah.flatten([1, [2, 3, [4]]] as [NSObject])
// -> [1, 2, 3, [4]
```

Flatten array one level.

#### Arguments ####

- array: The array to flatten.

#### Return ####

The new flattened array.

### `Hookah.flattenDeep`

```swift
Hookah.flattenDeep<T>(array: [T]) -> [T]
```

```swift
Hookah.flattenDeep([[1],2,[3,[[4]],5],[[6,7],8],[[9]]])
// -> [1,2,3,4,5,6,7,8,9]
```

This method is like Hookah.flatten except that it recursively flattens array.

#### Arguments ####

- array: The array to flatten.

#### Return ####

The new flattened array.

### `Hookah.fill` (value, indexes)

```swift
Hookah.fill<T>(inout array: [T], value: T, indexes: [Int])
```

```swift
var array = [1,2,3,4]
Hookah.fill(&array, value: 0, indexes: [1,3])
print(array)
-> logs [1,0,3,0]
```

Fill elements of array in indexes with value.

**NOTE:** This method mutates array.

#### Arguments ####

- array:   The pointer of the array to fill.
- value:   The value to fill the array with
- indexes: The indexes that the value will be filled.

### `Hookah.fill` (value, start, end)

```swift
Hookah.fill<T>(inout array: [T], value: T, start: Int = 0, end: Int? = nil)
```

```swift
var array = [1,2,3,4]
Hookah.fill(&array, value: 0, start: 0, end: 2)
print(array)
-> logs [0,0,3,4]
```

Fill elements of array with value from start upto, but not including end.

**NOTE:** This method mutates array.

#### Arguments ####

- array: The pointer of the array to fill.
- value: The value to fill the array with.
- start: The start position. `0` by default.
- end:   The end position. `nil` by default.

### `Hookah.findIndex`

```swift
Hookah.findIndex<T>(array: [T], predicate: T -> Bool) -> Int
```

```swift
Hookah.findIndex([1,2,3,4]) { $0 % 2 == 0 }
// -> 1 // index of 2
```

This method is like Hookah.find except that it returns the index of the first element predicate returns true for instead of the element itself.

#### Arguments ####

- array: The array to search.
- predicate: The function invoked per iteration.

#### Return ####

Returns the index of the found element, else -1.

### `Hookah.findLastIndex`

```swift
Hookah.findLastIndex<T>(array: [T], predicate: T -> Bool) -> Int
```

```swift
Hookah.findLastIndex([1,2,3,4]) { $0 % 2 == 0 }
// -> 3 // index of 4
```

This method is like Hookah.findIndex except that it iterates over elements of array from right to left.

#### Arguments ####

- array: The array to search.
- predicate: The function invoked per iteration.

#### Return ####

Returns the index of the found element, else -1.

### `Hookah.indexOf`

```swift
Hookah.indexOf<T where T:Equatable>(array:[T], value:T, fromIndex:UInt?=nil) -> Int?
```

```swift
Hookah.indexOf([1,2,1,2], value:2)
// -> 1 // index of first `2`
```

Gets the index at which the first occurrence of value is found in array.

#### Arguments ####

- array: The array to search.
- value: The value to search for.
- fromIndex: The index to search from. `nil` by default

#### Return ####

Returns the index of the found element, else -1.

### `Hookah.initial`

```swift
Hookah.initial<T>(array:[T]) -> [T]
```

```swift
Hookah.initial([1,2,3])
// -> [1,2]
```

Gets all but the last element of array.

#### Arguments ####

- array: The array to query.

#### Return ####

Returns the slice of array.

### `Hookah.intersection`

```swift
Hookah.intersection<T where T:Equatable>(arrays:[T]...) -> [T]
```

```swift
Hookah.intersection([2,1], [4,2], [1,2])
// -> [2]
```

Creates an array of unique values that are included in all of the provided arrays.

#### Arguments ####

- array: The arrays to inspect.

#### Return ####

Returns the new array of shared values.

### `Hookah.intersectionBy`

```swift
Hookah.intersectionBy<T where T:Equatable>(arrays:[T]..., iteratee:T->T) -> [T]
```

```swift
Hookah.intersectionBy([2.1, 1.2], [4.3, 2.4], iteratee:floor)
// -> [2.1]
```

This method is like Hookah.intersection except that it accepts iteratee which is invoked for each element of each arrays to generate the criterion by which uniqueness is computed.

#### Arguments ####

- array: The arrays to inspect.
- iteratee: The iteratee invoked per element.

#### Return ####

Returns the new array of shared values.

### `Hookah.intersectionWith`

```swift
Hookah.intersectionWith<T>(arrays:[T]..., comparator:(T,T)->Bool) -> [T] 
```

```swift
func compare(obj1:[String:Int], obj2:[String:Int]) -> Bool {
    if obj1["x"] == obj2["x"] && obj1["y"] == obj2["y"] {
        return true
    }
    return false;
}
let a1 = [["x":1, "y":2], ["x":2, "y":1]]
let a2 = [["x":1, "y":1], ["x":1, "y":2]]
Hookah.intersectionWith(a1, a2, comparator: compare)
// -> [["x":1, "y":2]]
```

This method is like Hookah.intersection except that it accepts comparator which is invoked to compare elements of arrays.

#### Arguments ####

- array: The arrays to inspect.
- comparator: The comparator invoked per element.

#### Return ####

Returns the new array of shared values.

### `Hookah.slice`

```swift
Hookah.slice<T>(array: [T], start: Int, end: Int? = nil) -> [T]
```

```swift
Hookah.slice([1,2,3,4,5], start: 0, end: 2)
// -> [1,2]
Hookah.slice([1,2,3,4,5], start: 3)
// -> [4, 5]
```

Create an array by slicing the array from start up to, but not including, end.

#### Arguments ####

- array: The array to slice.
- start: The start position.
- end:   The end position. `nil` by default.

#### Return ####

The sliced array.

# Roadmap #

- Finish methods for String and so on. (There is alot of work to do, guys.)
- Add more test cases.

# Contributing #
All contributions Hookah are extremely welcome. Checkout [CONTRIBUTING.md](https://github.com/khoiln/Hookah/blob/master/CONTRIBUTING.md)
