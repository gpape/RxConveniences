//
//  DisplayColor.swift
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

import CollectiveSwift
import RxCocoa
import RxSwift
import UIKit

extension UIView {

    internal func setDisplayColor(_ value: UIColor) {
        switch self {
        case let view as UIActivityIndicatorView:
            view.color = value
        case let view as UILabel:
            view.textColor = value
        case let view as UITextView:
            view.textColor = value
        default:
            tintColor = value
        }
    }

}

extension Reactive where Base: UIView {

    public var displayColor: RetainingBinder<UIColor> {
        return RetainingBinder(base) { base, value in
            base.setDisplayColor(value)
        }
    }

}

extension Reactive where Base: CollectiveType, Base.Element: UIView {

    public var displayColor: RetainingBinder<UIColor> {
        return RetainingBinder(base) { base, value in
            base.base.forEach { $0.setDisplayColor(value) }
        }
    }

}
