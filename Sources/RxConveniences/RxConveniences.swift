struct RxConveniences {
    var text = "Hello, World!"
}

import RxCocoa
import RxSwift

@propertyWrapper
final public class RxSignal {

    private let relay: PublishRelay<Void>

    public init() {
        relay = .init()
    }

    public var projectedValue: Signal<Void> {
        relay.asSignal()
    }

    public var wrappedValue: Void {
        ()
    }

    public func trigger() {
        relay.accept(())
    }

}

@propertyWrapper
final public class RxValue<T> {

    private let relay: BehaviorRelay<T>

    public init(value: T) {
        relay = .init(value: value)
    }

    public var projectedValue: Driver<T> {
        relay.asDriver()
    }

    public var wrappedValue: T {
        get { relay.value }
        set { relay.accept(newValue) }
    }

}
