//
//  ShowreelDebugViewController.swift
//  iOS Example
//
//  Created by Greg Pape on 12/28/20.
//

import RxCocoa
import RxSwift
import UIKit

final class ShowreelDebugViewController: UIViewController {

// MARK: - Interface

    @IBOutlet private weak var canvas: UIView!
    @IBOutlet private weak var contents: UIView!
    @IBOutlet private weak var controlsContainer: UIView!
    @IBOutlet private weak var controlsTop: NSLayoutConstraint!
    @IBOutlet private weak var gradientView: GradientView!

// MARK: -

    private let bag = DisposeBag()
    private var controls: ShowreelDebugControlsViewController!
    private var objects: [ShowreelDebugObject] = []

}

// MARK: - Rx

private extension ShowreelDebugViewController {

    func configureRx() {

        Driver.combineLatest(controls.$contentsPerspectiveDenominator, controls.$contentsRotation)
            .drive { [unowned self] denominator, rotation in
                var transform = CATransform3D.withPerspective(-1.0 / denominator)
                transform = CATransform3DRotate(transform, rotation, 0, -1, 0)
                contents.layer.transform = transform
            }
            .disposed(by: bag)

        Driver.combineLatest(controls.$objectPerspectiveDenominator, controls.$planeDistance)
            .drive { [unowned self] perspectiveDenominator, planeDistance in
                objects.all.apply(perspectiveDenominator: perspectiveDenominator, planeDistance: planeDistance)
            }
            .disposed(by: bag)

        controls.$profile
            .markingFirst()
            .subscribe(onNext: { [unowned self] profile, isFirst in
                configure(for: profile, animated: !isFirst)
            })
            .disposed(by: bag)

    }

}

// MARK: - UI

private extension ShowreelDebugViewController {

    func configure(for profile: ShowreelDebugControlsViewController.Profile, animated: Bool) {
        controlsTop.constant = -controls.height(for: profile)
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { [self] in
                view.layoutIfNeeded()
            }, completion: nil)
        } else {
            view.layoutIfNeeded()
        }
    }

    func makeTestObjects() {

        (0..<3).forEach {
            objects.append(ShowreelDebugObjectFactory.make(
                at: .init(x: 0, y: 0, z: 0),
                in: $0,
                withDisplayColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                objectPerspectiveDenominator: controls.objectPerspectiveDenominator,
                planeDistance: controls.planeDistance,
                constrainedTo: canvas)
            )
        }

    }

}

// MARK: - : UIViewController

extension ShowreelDebugViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.destination {
        case let vc as ShowreelDebugControlsViewController:
            controls = vc
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        controls.view.setNeedsLayout()
        controls.view.layoutIfNeeded()
        controlsContainer.layer.zPosition = .greatestFiniteMagnitude
        gradientView.gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
        configureRx()
        makeTestObjects()
    }

}
