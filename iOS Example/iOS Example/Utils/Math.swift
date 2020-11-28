//
//  Math.swift
//  iOS Example
//
//  Created by Greg Pape on 11/27/20.
//

import CoreGraphics

extension CGFloat {

    var clamped: CGFloat {
        clamped(to: 0...1)
    }

    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        let v = self < range.lowerBound ? range.lowerBound : self
        return v > range.upperBound ? range.upperBound : v
    }

}
