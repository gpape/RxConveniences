//
//  ShowreelViewModel.swift
//  iOS Example
//
//  Created by Greg Pape on 11/26/20.
//

import RxCocoa
import RxSwift
import UIKit

final class ShowreelViewModel {

    private let bag = DisposeBag()

    fileprivate let _color: BehaviorRelay<UIColor>
    fileprivate let spawn = PublishRelay<Showreel.Position>()

    init() {

        Driver<Int>.interval(.milliseconds(500))
            .map(to: Showreel.Position.random())
            .drive { [spawn] position in
                spawn.accept(position)
            }
            .disposed(by: bag)

        let colors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.4352941176, green: 0, blue: 1, alpha: 1), #colorLiteral(red: 0.4980392157, green: 0, blue: 1, alpha: 1)]
        _color = .init(value: colors[0])

        Driver<Int>.interval(.seconds(4))
            .map { colors[$0 % colors.count] }
            .drive(_color)
            .disposed(by: bag)

        Driver.displayLink() // TODO:
            .drive { link in
                print(link.timestamp)
            }
            .disposed(by: bag)

    }

}

// MARK: - API

extension ShowreelViewModel {

    var color: UIColor {
        _color.value
    }

}

// MARK: - Reactive

extension ShowreelViewModel: ReactiveCompatible { }

extension Reactive where Base: ShowreelViewModel {

    var color: Driver<UIColor> {
        base._color.asDriver()
    }

    var spawn: Signal<Showreel.Position> {
        base.spawn.asSignal()
    }

}
