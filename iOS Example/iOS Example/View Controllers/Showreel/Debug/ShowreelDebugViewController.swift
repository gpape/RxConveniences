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
    @IBOutlet private weak var controlsTop: NSLayoutConstraint!
    @IBOutlet private weak var gradientView: GradientView!

// MARK: -

    fileprivate typealias ControlsProfile = ShowreelDebugControlsViewController.Profile

    private let bag = DisposeBag()
    private var controls: ShowreelDebugControlsViewController!
    @RxValue private var controlsProfile: ControlsProfile = .collapsed

}

// MARK: - Rx

private extension ShowreelDebugViewController {

    func configureRx() {

        $controlsProfile
            .drive { [weak self] profile in
                self?.animate(to: profile)
            }
            .disposed(by: bag)

    }

}

// MARK: - UI

private extension ShowreelDebugViewController {

    func animate(to profile: ControlsProfile) {
        controlsTop.constant = -controls.height(for: profile)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { [self] in
            view.layoutIfNeeded()
        }, completion: nil)
    }

}

// MARK: - : UIViewController

extension ShowreelDebugViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.destination {
        case let vc as ShowreelDebugControlsViewController:
            vc.onDismiss = { [unowned self] in
                controlsProfile = controlsProfile.toggled
            }
            controls = vc
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        controls.view.setNeedsLayout()
        controls.view.layoutIfNeeded()
        controlsTop.constant = -controls.height(for: controlsProfile)
        gradientView.gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
        configureRx()
    }

}
