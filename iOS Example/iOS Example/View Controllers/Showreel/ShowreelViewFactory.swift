//
//  ShowreelViewFactory.swift
//  iOS Example
//
//  Created by Greg Pape on 11/27/20.
//

import UIKit

enum ShowreelViewFactory {

    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    static func make(at position: Showreel.Position) -> UIView {
        (Showreel.FeatureFlags.debug ? ViewType.label : ViewType.allCases.randomElement()!).make(at: position)
    }

}

// MARK: - Types

private enum ViewType: CaseIterable {

    case activityIndicator
    case label
    case slider
    case `switch`
    case symbol

    func make(at position: Showreel.Position) -> UIView {

        switch self {
        case .activityIndicator:

            let view = UIActivityIndicatorView(style: .large)
            view.startAnimating()
            return view

        case .label:

            let view = UILabel()
            view.font = .systemFont(ofSize: 60)
            view.text = ShowreelViewFactory.numberFormatter.string(from: NSNumber(value: abs(Double(position.z))))
            return view

        case .slider:

            let view = UISlider()
            view.value = .random(in: 0.333..<0.667)
            NSLayoutConstraint.activate([view.widthAnchor.constraint(equalToConstant: 100)])
            return view

        case .switch:

            let view = UISwitch()
            view.isOn = true
            return view

        case .symbol:

            return UIImageView(image: UIImage(systemName: names.randomElement()!, withConfiguration: config))

        }

    }

}

private let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .regular, scale: .default)

private let names = [
    "folder.badge.plus",
    "pencil.circle",
    "square.and.arrow.up",
    "trash",
    "tray.and.arrow.down.fill"
]
