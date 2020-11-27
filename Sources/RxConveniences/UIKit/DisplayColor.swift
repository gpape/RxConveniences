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

    public var displayColor: UIColor {
        get {
            switch self {
            case let view as UIActivityIndicatorView:
                return view.color
            case let view as UILabel:
                return view.textColor
            case let view as UISwitch:
                return view.onTintColor ?? .clear
            case let view as UITextView:
                return view.textColor ?? .clear
            default:
                return tintColor
            }
        }
        set {
            switch self {
            case let view as UIActivityIndicatorView:
                view.color = newValue
            case let view as UILabel:
                view.textColor = newValue
            case let view as UISwitch:
                view.onTintColor = newValue
            case let view as UITextView:
                view.textColor = newValue
            default:
                tintColor = newValue
            }
        }
    }

}

extension Collective where Element: UIView {

    public var displayColor: UIColor {
        get { Collective.gettersAreNotSupportedFailure() }
        set { base.forEach { $0.displayColor = newValue } }
    }

}

extension Reactive where Base: UIView {

    public var displayColor: RetainingBinder<UIColor> {
        return RetainingBinder(base) { base, value in
            base.displayColor = value
        }
    }

}

extension Reactive where Base: CollectiveType, Base.Element: UIView {

    public var displayColor: RetainingBinder<UIColor> {
        return RetainingBinder(base) { base, value in
            base.base.forEach { $0.displayColor = value }
        }
    }

}
