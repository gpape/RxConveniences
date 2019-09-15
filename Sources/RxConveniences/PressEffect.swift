//
//  PressEffect.swift
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
