//
//  CoreAnimation.swift
//  iOS Example
//
//  Created by Greg Pape on 1/2/21.
//

import QuartzCore

extension CATransform3D {

    static func withPerspective(_ m34: CGFloat) -> CATransform3D {
        var value = CATransform3DIdentity
        value.m34 = m34
        return value
    }

}
