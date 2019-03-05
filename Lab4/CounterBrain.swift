//
//  CounterBrain.swift
//  Lab4
//
//  Created by iosdev on 26/01/2019.
//  Copyright © 2019 iosdev. All rights reserved.
//

import Foundation

class CounterBrain {
    
    var minValue: Int = -10
    var maxValue: Int = 10
    private var value: Int = 0
    
    public func increase() {
        if (value < maxValue) {
            value += 1
        }
    }
    
    public func decrease() {
        if (value > minValue) {
            value -= 1
        }
    }
    
    public func reset() {
            value = 0
    }
    
    public func getValue() -> Int {
        return value
    }
}
