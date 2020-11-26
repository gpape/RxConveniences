//
//  ShowreelViewModel.swift
//  iOS Example
//
//  Created by Greg Pape on 11/26/20.
//

import RxCocoa
import RxSwift

final class ShowreelViewModel {

    private let bag = DisposeBag()

    init() {

        Observable<Int>.interval(.milliseconds(500), scheduler: SerialDispatchQueueScheduler(qos: .utility))
            .subscribe(onNext: { value in
                print(value)
            }, onError: { error in
                print(error)
            })
            .disposed(by: bag)

    }

}
