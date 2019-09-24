//
//  RxCasts.swift
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

import CoreGraphics
import RxCocoa
import RxSwift

extension ObservableType {

    /// Erases the type of an observable.
    func void() -> Observable<Void> {
        return map { _ in () }
    }

}

extension ObservableType where Element: BinaryFloatingPoint {

    /// Casts a floating-point observable to `CGFloat`, useful for UIKit.
    func cgFloat() -> Observable<CGFloat> {
        return map(CGFloat.init)
    }

}

extension SharedSequence {

    /// Erases the type of a shared sequence.
    func void() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in () }
    }

}

extension SharedSequence where Element: BinaryFloatingPoint {

    /// Casts a floating-point shared sequence to `CGFloat`, useful for UIKit.
    func cgFloat() -> SharedSequence<SharingStrategy, CGFloat> {
        return map(CGFloat.init)
    }

}
