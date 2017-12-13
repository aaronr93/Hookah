//
//  Number.swift
//  Hookah
//
//  Created by khoi on 1/22/16.
//  Copyright © 2016 Khoi Lai. All rights reserved.
//

import Foundation

extension Hookah {
    
    /**
     Return a random integer from lowerbound to upperbound inclusively
     
     - parameter upper: The upper bound
     - parameter lower: The lower bound
     
     - returns: A random integer
     */
    public class func random(lower: Int = 0, upper: Int = 1) -> Int{
        assert(upper >= lower, "Lowerbound must be smaller than upper bound")
        return Int(arc4random_uniform(UInt32(upper - lower + 1))) + lower
    }
}

