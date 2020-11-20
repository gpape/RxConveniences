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

        let light = `switch`.rx.isOn

        light
            .map { $0.color }
            .bind(to: view.rx.backgroundColor)
            .disposed(by: bag)

        (!light)
            .map { $0.color }
            .bind(to: [activityIndicator].all.rx.color,
                      tintable.all.rx.tintColor)
            .disposed(by: bag)

    }

}

private typealias LightsOn = Bool

private extension LightsOn {
    var color: UIColor { self ? #colorLiteral(red: 1, green: 0.9882352941, blue: 0.8980392157, alpha: 1) : #colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1) }
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
