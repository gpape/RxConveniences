//
//  BooleanOperators.swift
//  iOS Example
//
//  Created by Greg Pape on 11/19/20.
//

import RxCocoa
import RxSwift

extension ObservableType where Element == Bool {

    /// Applies logical negation.
    public static prefix func ! (observable: Self) -> Observable<Bool> {
        return observable.map { !$0 }
    }

}

// TODO: ...
