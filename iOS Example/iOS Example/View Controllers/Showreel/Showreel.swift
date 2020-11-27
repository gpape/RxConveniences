//
//  Showreel.swift
//  iOS Example
//
//  Created by Greg Pape on 11/26/20.
//

import UIKit

enum Showreel {

    struct Position {

        let x, y, z: CGFloat

        static func random() -> Self {
            .init(x: .random(in: (-UIScreen.width_2...UIScreen.width_2)),
                  y: .random(in: (-UIScreen.height_2...UIScreen.height_2)),
                  z: .random(in: (-250..<0)))
        }

    }

}
