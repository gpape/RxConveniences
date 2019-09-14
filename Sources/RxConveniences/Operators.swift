//
//  Operators.swift
//  RxConveniencesExample
//
//  Created by Greg Pape on 9/14/19.
//  Copyright © 2019 Greg Pape. All rights reserved.
//

import RxSwift

extension ObservableType where Element == Bool {

    public static prefix func ! (observable: Self) -> Observable<Bool> {
        return observable.map { !$0 }
    }

}
