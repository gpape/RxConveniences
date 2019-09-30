import RxTest
import XCTest
@testable import RxConveniences

final class RxConveniencesTests: XCTestCase {

    func testLogicalAND() {

        let scheduler = TestScheduler(initialClock: 0)

        let a = scheduler.createHotObservable([
            .next(100, true),
            .next(400, false),
            .next(500, true)
        ])

        let b = scheduler.createHotObservable([
            .next(300, true),
            .next(600, false),
            .next(700, true)
        ])

        // subscribed at 200
        // disposed at 1000
        let results = scheduler.start { a && b }

        let correctEvents = Recorded.events(
            .next(400, false),
            .next(500, true),
            .next(600, false),
            .next(700, true)
        )

        XCTAssertEqual(results.events, correctEvents)

    }

    func testLogicalOR() {

        let scheduler = TestScheduler(initialClock: 0)

        let a = scheduler.createHotObservable([
            .next(100, true),
            .next(400, false),
            .next(500, true)
        ])

        let b = scheduler.createHotObservable([
            .next(300, true),
            .next(600, false),
            .next(700, true)
        ])

        // subscribed at 200
        // disposed at 1000
        let results = scheduler.start { a || b }

        let correctEvents = Recorded.events(
            .next(400, true),
            .next(500, true),
            .next(600, true),
            .next(700, true)
        )

        XCTAssertEqual(results.events, correctEvents)

    }

    static var allTests = [
        ("testLogicalAND", testLogicalAND),
        ("testLogicalOR", testLogicalOR)
    ]

}
