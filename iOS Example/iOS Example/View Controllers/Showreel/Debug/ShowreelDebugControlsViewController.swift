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

        let animations: () -> Void = { [weak self] in
            self?.stackView.alpha = profile.controlsAlpha
        }

        let dismissButtonTransitions: () -> Void = { [weak self] in
            self?.dismissButton.setImage(profile.dismissIcon, for: .normal)
        }

        if animated {
            let duration: TimeInterval = 0.3
            let options: UIView.AnimationOptions = [.allowUserInteraction, .beginFromCurrentState]
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: animations, completion: nil)
            UIView.transition(with: dismissButton, duration: duration, options: options, animations: dismissButtonTransitions, completion: nil)
        } else {
            animations()
            dismissButtonTransitions()
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

    var controlsAlpha: CGFloat {
        switch self {
        case .collapsed:
            return 0
        case .expanded:
            return 1
        }
    }

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
