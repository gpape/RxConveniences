//
//  RetainingBinder.swift
//  RxConveniencesExample
//
//  Created by Greg Pape on 9/14/19.
//  Copyright © 2019 Greg Pape. All rights reserved.
//

import RxSwift

/// Analogous to `RxCocoa.Binder`, but retains its target.
public struct RetainingBinder<Value>: ObserverType {

    public typealias Element = Value

    private let binding: (Event<Value>) -> Void

    public init<Target: AnyObject>(_ target: Target, scheduler: ImmediateSchedulerType = MainScheduler(), binding: @escaping (Target, Value) -> Void) {
        self.binding = { event in
            switch event {
            case .next(let element):
                _ = scheduler.schedule(element) { element in
                    binding(target, element)
                    return Disposables.create()
                }
            case .error(let error):
                rxConveniencesBindingError(error)
            case .completed:
                break
            }
        }
    }

    public func asObserver() -> AnyObserver<Value> {
        return AnyObserver(eventHandler: on)
    }

    public func on(_ event: Event<Value>) {
        binding(event)
    }

}

func rxConveniencesBindingError(_ error: Error) {
    let error = "binding error: \(error)"
#if DEBUG
    rxConveniencesFatalError(error)
#else
    print(error)
#endif
}
