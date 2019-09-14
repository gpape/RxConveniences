//
//  UIActivityIndicatorView+MoreRx.swift
//  RxConveniencesExample
//
//  Created by Greg Pape on 9/14/19.
//  Copyright © 2019 Greg Pape. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: UIActivityIndicatorView {

    public var color: Binder<UIColor> {
        return Binder(base) { view, color in
            view.color = color
        }
    }

}
