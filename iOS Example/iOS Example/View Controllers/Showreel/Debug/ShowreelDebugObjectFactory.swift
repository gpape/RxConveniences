//
//  ShowreelDebugObjectFactory.swift
//  iOS Example
//
//  Created by Greg Pape on 1/2/21.
//

import UIKit

enum ShowreelDebugObjectFactory {

    static func make(at position: Showreel.Position,
                     in plane: Int,
                     withDisplayColor displayColor: UIColor,
                     objectPerspectiveDenominator: CGFloat,
                     planeDistance: CGFloat,
                     constrainedTo parent: UIView) -> ShowreelDebugObject {

        let z = CGFloat(plane) * planeDistance

        let view = UILabel()
        view.displayColor = displayColor
        view.font = .systemFont(ofSize: 60)
        view.text = ShowreelViewFactory.numberFormatter.string(from: NSNumber(value: abs(Double(z))))
        view.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(view)

        var transform = CATransform3D.withPerspective(-1.0 / objectPerspectiveDenominator)
        transform = CATransform3DTranslate(transform, 0, 0, z)
        view.layer.transform = transform
        view.layer.zPosition = z

        let x = view.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: position.x)
        let y = view.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: position.y)
        NSLayoutConstraint.activate([x, y])

        return .init(constraints: (x, y),
                     plane: plane,
                     view: view)

    }

}
