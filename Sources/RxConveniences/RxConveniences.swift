struct RxConveniences {
    var text = "Hello, World!"
}

import RxCocoa
import RxSwift

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    public func drive(onNext: @escaping (Element) -> Void) -> Disposable {
        drive(onNext: onNext, onCompleted: nil, onDisposed: nil)
    }

}

extension SharedSequenceConvertibleType where SharingStrategy == SignalSharingStrategy {

    public func emit(onNext: @escaping (Element) -> Void) -> Disposable {
        emit(onNext: onNext, onCompleted: nil, onDisposed: nil)
    }

}

@propertyWrapper
public struct RxValue<T> {

    private let relay: BehaviorRelay<T>
    private let driver: Driver<T>

    public init(wrappedValue: @autoclosure @escaping () -> T) {
        relay = .init(value: wrappedValue())
        driver = relay.asDriver()
    }

    public var projectedValue: Driver<T> {
        driver
    }

    public var wrappedValue: T {
        get { relay.value }
        set { relay.accept(newValue) }
    }

}
