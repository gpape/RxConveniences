//
//  PressEffect.swift
//  
//
//  Created by Greg Pape on 9/9/19.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIButton {

    public func addPressEffect(on view: UIView? = nil) -> Disposable {

        let view = view ?? base

        let down = base.rx.controlEvent(.touchDown)
            .map(to: true)

        let up = base.rx.controlEvent([.touchCancel, .touchDragExit, .touchUpInside])
            .map(to: false)

        return Observable.merge(up, down)
            .subscribe(onNext: { isPressed in
                UIView.animate(withDuration: 0.13, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { [weak view] in
                    view?.transform = isPressed ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
                }, completion: nil)
            })

    }

}
