struct RxConveniences {
    var text = "Hello, World!"
}

import RxCocoa

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
