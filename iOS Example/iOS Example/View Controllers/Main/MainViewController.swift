//
//  MainViewController.swift
//  iOS Example
//
//  Created by Greg Pape on 11/7/20.
//

import RxCocoa
import RxSwift
import UIKit

final class MainViewController: UIViewController {

// MARK: -

    private let bag = DisposeBag()
    private var vm = MainViewModel()

}

// MARK: - Rx

private extension MainViewController {

    func configureRx() {

        vm.$demos
            .debug()
            .drive()
            .disposed(by: bag)

    }

}

// MARK: - : UIViewController

extension MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRx()
    }

}
