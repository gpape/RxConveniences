//
//  Math.swift
//  RxConveniencesExample
//
//  Created by Greg Pape on 9/15/19.
//  Copyright © 2019 Greg Pape. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType where Element: FloatingPoint {

    public func clamp() -> Observable<Element> {
        return clamp(min: 0, max: 1)
    }

    public func clamp(min: Element, max: Element) -> Observable<Element> {
        return map { n in
            let v = n < min ? min : n
            return v > max ? max : v
        }
    }

}

extension SharedSequence where Element: FloatingPoint {

    public func clamp() -> SharedSequence<SharingStrategy, Element> {
        return clamp(min: 0, max: 1)
    }

    public func clamp(min: Element, max: Element) -> SharedSequence<SharingStrategy, Element> {
        return map { n in
            let v = n < min ? min : n
            return v > max ? max : v
        }
    }

}
