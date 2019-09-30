//
//  RxOperators.swift
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

extension ObservableType where Element == Bool {

    /// Applies a logical AND to two boolean `Observable`s via `combineLatest`.
    public static func && (left: Self, right: Self) -> Observable<Bool> {
        return Observable.combineLatest(left, right).map { $0.0 && $0.1 }
    }

    /// Applies a logical OR to two boolean `Observable`s via `combineLatest`.
    public static func || (left: Self, right: Self) -> Observable<Bool> {
        return Observable.combineLatest(left, right).map { $0.0 || $0.1 }
    }

    /// Apply logical negation to a boolean observable.
    public static prefix func ! (observable: Self) -> Observable<Bool> {
        return observable.map { !$0 }
    }

}

extension SharedSequence where Element == Bool {

    /// Applies a logical AND to two boolean `SharedSequence`s via `combineLatest`.
    public static func && (left: Self, right: Self) -> Self {
        return .combineLatest(left, right) { $0 && $1 }
    }

    /// Applies a logical OR to two boolean `SharedSequence`s via `combineLatest`.
    public static func || (left: Self, right: Self) -> Self {
        return .combineLatest(left, right) { $0 || $1 }
    }

    /// Apply logical negation to a boolean shared sequence.
    public static prefix func ! (observable: Self) -> Self {
        return observable.map { !$0 }
    }

}
