//
//  UIView+RxConveniences.swift
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

import CollectiveSwift
import RxCocoa
import RxSwift
import UIKit

// MARK: - Additional

extension Reactive where Base: UIView {

    /// Bindable sink for the layer's `borderColor` property.
    public var borderColor: Binder<UIColor> {
        return Binder(base) { base, value in
            base.layer.borderColor = value.cgColor
        }
    }

    /// Bindable sink for the layer's `borderWidth` property.
    public var borderWidth: Binder<CGFloat> {
        return Binder(base) { base, value in
            base.layer.borderWidth = value
        }
    }

    /// Bindable sink for the `tintColor` property.
    public var tintColor: Binder<UIColor> {
        return Binder(base) { base, value in
            base.tintColor = value
        }
    }

    /// Bindable sink for the `transform` property.
    public var transform: Binder<CGAffineTransform> {
        return Binder(base) { base, value in
            base.transform = value
        }
    }

}

// MARK: - Collective

extension Reactive where Base: CollectiveType, Base.Element: UIView {

    /// Bindable sink for each view's `alpha` property.
    public var alpha: RetainingBinder<CGFloat> {
        return RetainingBinder(base) { base, value in
            base.base.forEach { $0.alpha = value }
        }
    }

    /// Bindable sink for each view's `backgroundColor` property.
    public var backgroundColor: RetainingBinder<UIColor> {
        return RetainingBinder(base) { base, value in
            base.base.forEach { $0.backgroundColor = value }
        }
    }

    /// Bindable sink for each view's layer's `borderColor` property.
    public var borderColor: RetainingBinder<UIColor> {
        return RetainingBinder(base) { base, value in
            base.base.forEach { $0.layer.borderColor = value.cgColor }
        }
    }

    /// Bindable sink for each view's layer's `borderWidth` property.
    public var borderWidth: RetainingBinder<CGFloat> {
        return RetainingBinder(base) { base, value in
            base.base.forEach { $0.layer.borderWidth = value }
        }
    }

    /// Bindable sink for each view's `isHidden` property.
    public var isHidden: RetainingBinder<Bool> {
        return RetainingBinder(base) { base, value in
            base.base.forEach { $0.isHidden = value }
        }
    }

    /// Bindable sink for each view's `isUserInteractionEnabled` property.
    public var isUserInteractionEnabled: RetainingBinder<Bool> {
        return RetainingBinder(base) { base, value in
            base.base.forEach { $0.isUserInteractionEnabled = value }
        }
    }

    /// Bindable sink for each view's `tintColor` property.
    public var tintColor: RetainingBinder<UIColor> {
        return RetainingBinder(base) { base, value in
            base.base.forEach { $0.tintColor = value }
        }
    }

    /// Bindable sink for each view's `transform` property.
    public var transform: RetainingBinder<CGAffineTransform> {
        return RetainingBinder(base) { base, value in
            base.base.forEach { $0.transform = value }
        }
    }

}

#endif
