//
//  CollectiveBindingsViewController.swift
//  iOS Example
//
//  Created by Greg Pape on 11/12/20.
//

import RxCocoa
import RxSwift
import UIKit

// MARK: - The gist

private extension CollectiveBindingsViewController {

    func configureRx() {

        `switch`.rx.isOn
            .map { $0.color }
            .bind(to: view.rx.backgroundColor) // TODO:
            .disposed(by: bag)

    }

}

private typealias LightsOn = Bool

private extension LightsOn {
    var color: UIColor { self ? .red : .blue }
}

// MARK: -

final class CollectiveBindingsViewController: UIViewController {

// MARK: - Interface

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var `switch`: UISwitch!
    @IBOutlet private var tintable: [UIView]!

// MARK: -

    private let bag = DisposeBag()

}

// MARK: - : UIViewController

extension CollectiveBindingsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRx()
    }

}
