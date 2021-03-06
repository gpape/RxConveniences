//
//  ControlProperty+.swift
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

extension ControlProperty {

    /// Convenience function for binding a `ControlProperty`.
    public func bind<Observer: ObserverType>(to observers: Observer...) -> Disposable where Observer.Element == Element {
        return bind(to: observers)
    }

    /// Convenience function for binding a `ControlProperty`.
    public func bind<Observer: ObserverType>(to observers: [Observer]) -> Disposable where Observer.Element == Element {
        return subscribe { event in
            observers.forEach { $0.on(event) }
        }
    }

    /// Convenience function for mapping a `ControlProperty`.
    public func map<T>(_ transform: @escaping (Element) -> T) -> Driver<T> {
        return asDriver().map(transform)
    }

    /// Convenience function for triggers from a `ControlProperty`.
    public func trigger<Observer: ObserverType>(_ observers: Observer...) -> Disposable where Observer.Element == Void {
        return asObservable().trigger(observers)
    }

}
