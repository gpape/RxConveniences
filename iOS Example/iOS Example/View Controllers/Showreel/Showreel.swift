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
            .init(x: .random(in: (0..<UIScreen.main.bounds.width)),
                  y: .random(in: (0..<UIScreen.main.bounds.height)),
                  z: .random(in: (-200..<0)))
        }

    }

}
