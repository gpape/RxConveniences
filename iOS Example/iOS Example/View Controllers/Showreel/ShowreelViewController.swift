//
//  ShowreelViewController.swift
//  iOS Example
//
//  Created by Greg Pape on 11/26/20.
//

import UIKit

final class ShowreelViewController: UIViewController {

    private var vm: ShowreelViewModel?

}

// MARK: - : UIViewController

extension ShowreelViewController {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vm == nil ? vm = .init() : ()
    }

}
