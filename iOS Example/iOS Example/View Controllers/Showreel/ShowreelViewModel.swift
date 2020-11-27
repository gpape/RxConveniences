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

    fileprivate let spawn = PublishRelay<Showreel.Position>()

    init() {

        Driver<Int>.interval(.milliseconds(500))
            .map(to: Showreel.Position.random())
            .drive { [spawn] position in
                spawn.accept(position)
            }
            .disposed(by: bag)

    }

}

// MARK: - Reactive

extension ShowreelViewModel: ReactiveCompatible { }

extension Reactive where Base: ShowreelViewModel {

    var spawn: Signal<Showreel.Position> {
        base.spawn.asSignal()
    }

}
