//
//  Driver+Conveniences.swift
//  RxConveniencesExample
//
//  Created by Greg Pape on 9/14/19.
//  Copyright © 2019 Greg Pape. All rights reserved.
//

import RxCocoa
import RxSwift

extension Driver {

    public func drive<T: ObserverType>(_ observers: T...) -> Disposable where T.Element == Element {
        return asSharedSequence().asObservable().subscribe { event in
            observers.forEach { $0.on(event) }
        }
    }

}
