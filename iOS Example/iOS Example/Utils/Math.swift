//
//  Math.swift
//  iOS Example
//
//  Created by Greg Pape on 11/27/20.
//

import CoreGraphics

extension CGFloat {

    var clamped: CGFloat {
        clamped(between: 0, and: 1)
    }

    func clamped(between min: CGFloat, and max: CGFloat) -> CGFloat {
        let v = self < min ? min : self
        return v > max ? max : v
    }

}
