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
    @IBOutlet private      var sliders: [UISlider]!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var visualEffectView: UIVisualEffectView!

// MARK: -

    private let bag = DisposeBag()

// MARK: - API

    private typealias Defaults = ShowreelDebug.Defaults

    @RxValue private(set) var contentsPerspectiveDenominator = Defaults.contentsPerspectiveDenominator
    @RxValue private(set) var contentsRotation = Defaults.contentsRotation
    @RxValue private(set) var objectPerspectiveDenominator = Defaults.objectPerspectiveDenominator
    @RxValue private(set) var planeDistance = Defaults.planeDistance
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
        setDefaults()
    }

    @IBAction func tapPrint(_: Any) {
        sliders.forEach { slider in
            debug(for: slider).flatMap { print($0, slider.value) }
        }
    }

    @IBAction func valueChanged(_ sender: Any, forEvent event: UIEvent) {

        guard let slider = sender as? UISlider else {
            return
        }

        switch slider {
        case contentsPerspectiveDenominatorSlider:
            contentsPerspectiveDenominator = CGFloat(slider.value)
        case contentsRotationSlider:
            contentsRotation = CGFloat(slider.value)
        case objectPerspectiveDenominatorSlider:
            objectPerspectiveDenominator = CGFloat(slider.value)
        case planeDistanceSlider:
            planeDistance = CGFloat(slider.value)
        default:
            break
        }

        if case .ended = event.allTouches?.first?.phase, let debug = debug(for: slider) {
            print(debug, slider.value)
        }

    }

}

// MARK: - Debug

private extension ShowreelDebugControlsViewController {

    func debug(for slider: UISlider) -> String? {
        switch slider {
        case contentsPerspectiveDenominatorSlider:
            return "contents perspective denominator"
        case contentsRotationSlider:
            return "contents rotation"
        case objectPerspectiveDenominatorSlider:
            return "object perspective denominator"
        case planeDistanceSlider:
            return "plane distance"
        default:
            return nil
        }
    }

    func setDefaults() {
        contentsPerspectiveDenominatorSlider.value = Float(Defaults.contentsPerspectiveDenominator)
        contentsRotationSlider.value = Float(Defaults.contentsRotation)
        objectPerspectiveDenominatorSlider.value = Float(Defaults.objectPerspectiveDenominator)
        planeDistanceSlider.value = Float(Defaults.planeDistance)
        sliders.forEach {
            $0.sendActions(for: .valueChanged)
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
        setDefaults()
        printButton.setImage(UIImage(systemName: "printer", withConfiguration: symbolConfiguration), for: .normal)
        resetButton.setImage(UIImage(systemName: "arrow.uturn.backward", withConfiguration: symbolConfiguration), for: .normal)
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
