//
//  MainViewController.swift
//  RxConveniencesExample
//
//  Created by Greg Pape on 9/11/19.
//  Copyright © 2019 Greg Pape. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

final class MainViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var `switch`: UISwitch!
    @IBOutlet private var tintableViews: [UIView]!

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRx()
    }

    private func configureRx() {

        button.rx
            .addPressEffect()
            .disposed(by: bag)

        let theme = `switch`.map(Theme.init)

        theme
            .map { $0.backgroundColor }
            .drive(view.rx.backgroundColor)
            .disposed(by: bag)

        theme
            .map { $0.tintColor }
            .drive(activityIndicator.rx.color.asObserver(), tintableViews.all.rx.tintColor.asObserver())
            .disposed(by: bag)

    }

}

// MARK: - Theme

private enum Theme {

    case dark, light

    static let darkColor = #colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)
    static let lightColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.8980392157, alpha: 1)

    init(_ isOn: Bool) {
        self = isOn ? .light : .dark
    }

    var backgroundColor: UIColor {
        return self == .light ? Theme.darkColor : Theme.lightColor
    }

    var tintColor: UIColor {
        return self == .light ? Theme.lightColor : Theme.darkColor
    }

}
