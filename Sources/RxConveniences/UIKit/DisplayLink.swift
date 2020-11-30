//
//  DisplayLink.swift
//
//  Copyright (c) 2020 Greg Pape (http://www.gpape.com/)
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

#if os(iOS) || os(tvOS)

import RxCocoa
import RxSwift
import UIKit

extension ObservableType where Element == CADisplayLink {

    public static func displayLink(on runLoop: RunLoop = .main, forMode mode: RunLoop.Mode = .common) -> Observable<CADisplayLink> {

        Observable<CADisplayLink>.create { observer in

            let link = DisplayLink(on: runLoop, forMode: mode) {
                observer.onNext($0)
            }

            return Disposables.create {
                link.invalidate()
            }

        }

    }

}

extension SharedSequence where Element == CADisplayLink {

    public static func displayLink(forMode mode: RunLoop.Mode = .common) -> SharedSequence<SharingStrategy, CADisplayLink> {
        Observable.displayLink(on: .main, forMode: .common)
            .asSharedSequence(sharingStrategy: SharingStrategy.self) { error in
                preconditionFailure("shouldn't error: \(error)")
            }
    }

}

// MARK: - Display link wrapper class

private final class DisplayLink {

    private var link: CADisplayLink?

    private let onStep: (CADisplayLink) -> Void

    init(on runLoop: RunLoop, forMode mode: RunLoop.Mode, onStep: @escaping (CADisplayLink) -> Void) {
        self.onStep = onStep
        link = .init(target: self, selector: #selector(step(_:)))
        link!.add(to: runLoop, forMode: mode)
    }

    deinit {
        invalidate()
    }

    func invalidate() {
        link?.invalidate()
        link = nil
    }

    @objc private func step(_ displayLink: CADisplayLink) {
        onStep(displayLink)
    }

}

#endif
