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

// MARK: - Interface

    @IBOutlet private weak var collectionView: UICollectionView!

// MARK: -

    private let bag = DisposeBag()
    private var dataSource: MainDataSource!
    private let vm = MainViewModel()

}

// MARK: - Rx

private extension MainViewController {

    func configureRx() {

        dataSource.rx.selection
            .emit { [weak self] demo in
                print(demo) // TODO:
            }
            .disposed(by: bag)

    }

}

// MARK: - : UIViewController

extension MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = .init(collectionView, vm: vm)
        configureRx()
    }

}
