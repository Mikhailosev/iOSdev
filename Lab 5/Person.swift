//
//  Person.swift
//  Lab 5
//
//  Created by iosdev on 26/01/2019.
//  Copyright © 2019 iosdev. All rights reserved.
//

import Foundation

class Person {
    
    var name: String
    var height: Double
    var weight: Double
    var bmi: Double?
    
    init?(name: String, height: Double, weight: Double) {
        
        guard !name.isEmpty ||  weight < 1 || height < 1 else {
            return nil
        }
        
        self.name = name
        self.height = height / 100
        self.weight = weight
        self.bmi = Double(weight/(height*height))
    }
    
    func getBMI() -> Double {
        bmi = Double(weight/(height*height))
        return bmi ?? 0
    }
    
}
