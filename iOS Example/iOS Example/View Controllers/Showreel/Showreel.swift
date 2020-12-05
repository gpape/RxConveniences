//
//  Showreel.swift
//  iOS Example
//
//  Created by Greg Pape on 11/26/20.
//

import UIKit

enum Showreel {

    enum FeatureFlags {
        static let debug = true
    }

    struct Position {

        let x, y, z: CGFloat

        static func random() -> Self {
            .init(x: .random(in: (-UIScreen.width_2...UIScreen.width_2)),
                  y: .random(in: (-UIScreen.height_2...UIScreen.height_2)),
                  z: .random(in: (-500..<0)))
        }

        func distance(to other: Position) -> CGFloat {
            sqrt(pow(x - other.x, 2) + pow(y - other.y, 2) + pow(z - other.z, 2))
        }

    }

    static let origin = Position(x: 0, y: 0, z: -333)

    static let waveSpeed: CGFloat = 667

}
