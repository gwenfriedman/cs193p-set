//
//  Theme.swift
//  Set
//
//  Created by Gwen Friedman on 2/7/22.
//

import Foundation

struct Theme {
    var name: String
    var shapes: [String]
    var colors: [String]
    var numbers: [Int]
    var shadings: [String]
    
    init(name: String, shapes: [String], colors: [String], numbers: [Int], shadings: [String]) {
        self.name = name
        self.shapes = shapes
        self.colors = colors
        self.numbers = numbers
        self.shadings = shadings
    }
}
