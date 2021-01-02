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

    @IBOutlet private weak var contentsPerspectiveDenominatorSlider: UISlider!
    @IBOutlet private weak var contentsRotationSlider: UISlider!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var objectPerspectiveDenominatorSlider: UISlider!
    @IBOutlet private weak var planeDistanceSlider: UISlider!
    @IBOutlet private weak var printButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var visualEffectView: UIVisualEffectView!

// MARK: -

    private let bag = DisposeBag()

// MARK: - API

    @RxValue private(set) var contentsPerspectiveDenominator: Float = 250
    @RxValue private(set) var contentsRotation: Float = 0.03125
    @RxValue private(set) var objectPerspectiveDenominator: Float = 250
    @RxValue private(set) var planeDistance: Float = 100
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

    @IBAction func reset(_: Any) {
        print("TODO:", #function)
    }

    @IBAction func tapPrint(_: Any) {
        // TODO: abstract away redundancy
        print("contents perspective denominator", contentsPerspectiveDenominatorSlider.value)
        print("contents rotation", contentsRotationSlider.value)
        print("object perspective denominator", objectPerspectiveDenominatorSlider.value)
        print("plane distance", planeDistanceSlider.value)
    }

    @IBAction func valueChanged(_ sender: Any, forEvent event: UIEvent) {

        guard let slider = sender as? UISlider else {
            return
        }

        switch slider {
        case contentsPerspectiveDenominatorSlider:
            contentsPerspectiveDenominator = slider.value
        case contentsRotationSlider:
            contentsRotation = slider.value
        case objectPerspectiveDenominatorSlider:
            objectPerspectiveDenominator = slider.value
        case planeDistanceSlider:
            planeDistance = slider.value
        default:
            break
        }

        if case .ended = event.allTouches?.first?.phase {
            let debug: String?
            switch slider {
            case contentsPerspectiveDenominatorSlider:
                debug = "contents perspective denominator"
            case contentsRotationSlider:
                debug = "contents rotation"
            case objectPerspectiveDenominatorSlider:
                debug = "object perspective denominator"
            case planeDistanceSlider:
                debug = "plane distance"
            default:
                debug = nil
            }
            debug.flatMap { print($0, slider.value) }
        }

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
            self?.printButton.alpha = profile.controlsAlpha
            self?.resetButton.alpha = profile.controlsAlpha
            self?.stackView.alpha = profile.controlsAlpha
            self?.visualEffectView.alpha = profile.controlsAlpha
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
        contentsPerspectiveDenominatorSlider.value = contentsPerspectiveDenominator
        contentsRotationSlider.value = contentsRotation
        objectPerspectiveDenominatorSlider.value = objectPerspectiveDenominator
        planeDistanceSlider.value = planeDistance
        printButton.setImage(UIImage(systemName: "printer", withConfiguration: symbolConfiguration), for: .normal)
        configureRx()
    }

}

// MARK: -

private let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold, scale: .default)

private extension ShowreelDebugControlsViewController.Profile {

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
