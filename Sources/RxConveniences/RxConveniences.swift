struct RxConveniences {
    var text = "Hello, World!"
}

import CollectiveSwift
import RxCocoa
import RxSwift

extension Collective: ReactiveCompatible {
}

extension Reactive where Base: Collective<UIView> {

    public var tintColor: RetainingBinder<UIColor> {
        return RetainingBinder(base) { all, color in
            all.tintColor = color
        }
    }

}

func rxConveniencesFatalError(_ lastMessage: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> Never  {
    fatalError(lastMessage(), file: file, line: line)
}
