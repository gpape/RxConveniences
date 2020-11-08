//
//  MainViewModel.swift
//  iOS Example
//
//  Created by Greg Pape on 11/7/20.
//

import RxCocoa
import RxSwift

final class MainViewModel {

    enum Demo {
        case collectiveBindings
        case showreel
    }

    @RxValue(value: [])
    private(set) var demos: [Demo]

    private let bag = DisposeBag()

    init() {

        Observable<Int>.interval(.milliseconds(500), scheduler: MainScheduler.instance)
            .take(2)
            .subscribe(onNext: { [weak self] interval in
                switch interval {
                case 0:
                    self?.demos.append(.collectiveBindings)
                case 1:
                    self?.demos.append(.showreel)
                default:
                    break
                }
            })
            .disposed(by: bag)

    }

}
