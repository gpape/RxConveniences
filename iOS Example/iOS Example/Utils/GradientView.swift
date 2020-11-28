//
//  GradientView.swift
//  iOS Example
//
//  Created by Greg Pape on 11/27/20.
//

import UIKit

final class GradientView: UIView {

    var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

}
