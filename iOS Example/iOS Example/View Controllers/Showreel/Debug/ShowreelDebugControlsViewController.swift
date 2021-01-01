//
//  ShowreelDebugControlsViewController.swift
//  iOS Example
//
//  Created by Greg Pape on 12/31/20.
//

import RxCocoa
import RxSwift
import UIKit

final class ShowreelDebugControlsViewController: UIViewController {

// MARK: - Interface

    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!

// MARK: -

    private let bag = DisposeBag()

// MARK: - API

    @RxValue private(set) var profile: Profile = .collapsed

}

// MARK: - API

extension ShowreelDebugControlsViewController {

    enum Profile {
        case collapsed, expanded
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
        profile = profile.toggled
    }

}

// MARK: - Rx

private extension ShowreelDebugControlsViewController {

    func configureRx() {

        $profile
            .markingFirst()
            .subscribe(onNext: { [unowned self] profile, isFirst in
                configure(for: profile, animated: !isFirst)
            })
            .disposed(by: bag)

    }

}

// MARK: - UI

private extension ShowreelDebugControlsViewController {

    func configure(for profile: Profile, animated: Bool) {
        if animated {
            UIView.transition(with: dismissButton, duration: 0.3, options: [.allowUserInteraction, .beginFromCurrentState], animations: { [unowned self] in
                dismissButton.setImage(profile.dismissIcon, for: .normal)
            }, completion: nil)
        } else {
            dismissButton.setImage(profile.dismissIcon, for: .normal)
        }
    }

}

// MARK: - : UIViewController

extension ShowreelDebugControlsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRx()
    }

}

// MARK: -

private extension ShowreelDebugControlsViewController.Profile {

    private static let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 42, weight: .semibold, scale: .default)
    private static let dismissCollapsed = UIImage(systemName: "slider.horizontal.3", withConfiguration: symbolConfiguration)!
    private static let dismissExpanded = UIImage(systemName: "xmark", withConfiguration: symbolConfiguration)!

    var dismissIcon: UIImage {
        switch self {
        case .collapsed:
            return Self.dismissCollapsed
        case .expanded:
            return Self.dismissExpanded
        }
    }

    var toggled: Self {
        switch self {
        case .collapsed:
            return .expanded
        case .expanded:
            return .collapsed
        }
    }

}
