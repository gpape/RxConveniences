//
//  ShowreelDebugControlsViewController.swift
//  iOS Example
//
//  Created by Greg Pape on 12/31/20.
//

import UIKit

final class ShowreelDebugControlsViewController: UIViewController {

// MARK: - Set before loading

    var onDismiss: (() -> Void)?

// MARK: - Interface

    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!

}

// MARK: - API

extension ShowreelDebugControlsViewController {

    enum Profile {

        case collapsed, expanded

        var toggled: Profile {
            switch self {
            case .collapsed:
                return .expanded
            case .expanded:
                return .collapsed
            }
        }

    }

    func height(for profile: Profile) -> CGFloat {
        switch profile {
        case .collapsed:
            return dismissButton.frame.maxY
        case .expanded:
            return stackView.frame.maxY
        }
    }

}

// MARK: - Actions

private extension ShowreelDebugControlsViewController {

    @IBAction func dismiss(_: Any) {
        onDismiss?()
    }

}

// MARK: - : UIViewController

extension ShowreelDebugControlsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // ...
    }

}
