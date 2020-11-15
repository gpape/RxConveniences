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
                self?.show(demo)
            }
            .disposed(by: bag)

    }

}

// MARK: - Flow

private extension UIViewController {

    func show(_ demo: MainViewModel.Demo) {
        let vc: UIViewController
        switch demo {
        case .collectiveBindings:
            vc = UIStoryboard(name: "CollectiveBindings", bundle: nil).instantiateInitialViewController()!
        case .showreel:
            print("TODO:"); return
        }
        present(vc, animated: true, completion: nil)
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
