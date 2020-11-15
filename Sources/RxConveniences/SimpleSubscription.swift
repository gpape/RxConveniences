//
//  SimpleSubscription.swift
//  iOS Example
//
//  Created by Greg Pape on 11/14/20.
//

import RxCocoa
import RxSwift

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    /// Enables a cleaner call site for `drive` when we are not interested in `onCompleted` or `onDisposed`.
    public func drive(onNext: @escaping (Element) -> Void) -> Disposable {
        drive(onNext: onNext, onCompleted: nil, onDisposed: nil)
    }

}

extension SharedSequenceConvertibleType where SharingStrategy == SignalSharingStrategy {

    /// Enables a cleaner call site for `emit` when we are not interested in `onCompleted` or `onDisposed`.
    public func emit(onNext: @escaping (Element) -> Void) -> Disposable {
        emit(onNext: onNext, onCompleted: nil, onDisposed: nil)
    }

}
