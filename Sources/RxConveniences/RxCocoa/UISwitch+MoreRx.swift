//
//  UISwitch+MoreRx.swift
//  RxConveniencesExample
//
//  Created by Greg Pape on 9/14/19.
//  Copyright © 2019 Greg Pape. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension UISwitch {

    public func bind<T: ObserverType>(to observers: T...) -> Disposable where T.Element == Bool {
        return rx.value.subscribe { event in
            observers.forEach { $0.on(event) }
        }
    }

    public func map<T>(_ transform: @escaping (Bool) -> T) -> Driver<T> {
        return rx.value.asDriver().map(transform)
    }

}
