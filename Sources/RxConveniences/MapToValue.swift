//
//  MapToValue.swift
//  
//
//  Created by Greg Pape on 9/9/19.
//

import RxCocoa
import RxSwift

extension ObservableType {

    public func map<T>(to value: T) -> Observable<T> {
        return map { _ in value }
    }

}

extension SharedSequenceConvertibleType {

    public func map<T>(to value: T) -> SharedSequence<SharingStrategy, T> {
        return map { _ in value }
    }

}
