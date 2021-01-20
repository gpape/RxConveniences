//
//  ShowreelDebugObject.swift
//  iOS Example
//
//  Created by Greg Pape on 1/1/21.
//

import CollectiveSwift
import UIKit

struct ShowreelDebugObject {
    let constraints: (x: NSLayoutConstraint, y: NSLayoutConstraint)
    let plane: Int
    let view: UIView
}

// MARK: - API

extension ShowreelDebugObject {

    func apply(perspectiveDenominator: CGFloat, planeDistance: CGFloat) {
        let z = CGFloat(plane) * planeDistance
        view.layer.transform = CATransform3DTranslate(.withPerspective(-1.0 / perspectiveDenominator), 0, 0, z)
        view.layer.zPosition = z
    }

}

// MARK: - API (collective)

extension Collective where Element == ShowreelDebugObject {

    func apply(perspectiveDenominator: CGFloat, planeDistance: CGFloat) {
        base.forEach { $0.apply(perspectiveDenominator: perspectiveDenominator, planeDistance: planeDistance) }
    }

}
