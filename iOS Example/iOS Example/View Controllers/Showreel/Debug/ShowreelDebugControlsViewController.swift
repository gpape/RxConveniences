//
//  ShowreelDebugControlsViewController.swift
//  iOS Example
//
//  Created by Greg Pape on 12/31/20.
//

import UIKit

final class ShowreelDebugControlsViewController: UIViewController {

    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - API

extension ShowreelDebugControlsViewController {

    var collapsedHeight: CGFloat {
        dismissButton.frame.maxY
    }

    var expandedHeight: CGFloat {
        stackView.frame.maxY
    }

}

// MARK: - : UIViewController

extension ShowreelDebugControlsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // ...
    }

}
