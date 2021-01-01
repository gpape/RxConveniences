//
//  ShowreelDebugViewController.swift
//  iOS Example
//
//  Created by Greg Pape on 12/28/20.
//

import UIKit

final class ShowreelDebugViewController: UIViewController {

// MARK: - Interface

    @IBOutlet private weak var canvas: UIView!
    @IBOutlet private weak var contents: UIView!
    @IBOutlet private weak var controlsTop: NSLayoutConstraint!
    @IBOutlet private weak var gradientView: GradientView!

// MARK: -

    private var controls: ShowreelDebugControlsViewController!

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
        controlsTop.constant = -controls.collapsedHeight // TODO: rx
    }

}
