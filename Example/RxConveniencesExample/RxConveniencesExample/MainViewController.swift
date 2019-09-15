//
//  MainViewController.swift
//
//  Copyright (c) 2019 Greg Pape (http://www.gpape.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import RxSwift
import UIKit

final class MainViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var `switch`: UISwitch!
    @IBOutlet private var tintableViews: [UIView]!

    private let bag = DisposeBag()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = button.bounds.height / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRx()
    }

    private func configureRx() {

        button.rx
            .addPressEffect()
            .disposed(by: bag)

        let lightsOn = `switch`.rx.isOn

        lightsOn
            .map { $0.color }
            .bind(to: view.rx.backgroundColor)
            .disposed(by: bag)

        (!lightsOn)
            .map { $0.color }
            .bind(to:
                activityIndicator.rx.color.asObserver(),
                tintableViews.all.rx.tintColor.asObserver())
            .disposed(by: bag)

        (!lightsOn)
            .map { $0.color }
            .bind(to: button.rx.borderColor)
            .disposed(by: bag)

    }

}

// MARK: - Colors

private typealias LightsOn = Bool

private extension LightsOn {

    var color: UIColor {
        return self ? #colorLiteral(red: 1, green: 0.9882352941, blue: 0.8980392157, alpha: 1) : #colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)
    }

}
