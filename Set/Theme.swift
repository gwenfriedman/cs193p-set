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
    
    init(name: String, shapes: [String], colors: [String]) {
        self.name = name
        self.shapes = shapes
        self.colors = colors
    }
}
