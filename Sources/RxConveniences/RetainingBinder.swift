//
//  RetainingBinder.swift
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
//  Based on code from RxSwift (https://github.com/ReactiveX/RxSwift/), subject
//  to the same license.
//

import RxSwift

/// Analogous to `RxCocoa.Binder`, but retains its target.
public struct RetainingBinder<Value>: ObserverType {

    public typealias Element = Value

    private let binding: (Event<Value>) -> Void

    public init<Target>(_ target: Target, scheduler: ImmediateSchedulerType = MainScheduler(), binding: @escaping (Target, Value) -> Void) {
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
