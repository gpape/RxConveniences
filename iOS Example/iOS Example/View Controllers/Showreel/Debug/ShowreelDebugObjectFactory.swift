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

        let view = UILabel()
        view.displayColor = displayColor
        view.font = .systemFont(ofSize: 60)
        view.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(view)

        let x = view.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: position.x)
        let y = view.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: position.y)
        NSLayoutConstraint.activate([x, y])

        let object = ShowreelDebugObject(constraints: (x, y), plane: plane, view: view)
        object.apply(perspectiveDenominator: objectPerspectiveDenominator, planeDistance: planeDistance)
        view.text = ShowreelViewFactory.numberFormatter.string(from: NSNumber(value: abs(Double(object.view.layer.zPosition))))
        return object

    }

}
