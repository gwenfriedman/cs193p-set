//
//  Diamond.swift
//  Set
//
//  Created by Gwen Friedman on 2/7/22.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        
        let top = CGPoint(x: rect.maxX/2, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.maxY/2)
        let bottom = CGPoint(x: rect.maxX/2, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.maxY/2)
        
        var p = Path()
        p.move(to: top)
        p.addLine(to: right)
        p.addLine(to: bottom)
        p.addLine(to: left)
        p.addLine(to: top)
        
        return p
    }
    
    
}
