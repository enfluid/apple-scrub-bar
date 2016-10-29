import XCTest
@testable import SlidingSegmentedControl

class PanGestureRecognizerTests: XCTestCase {

    let panGestureRecognizer = PanGestureRecognizer()

    // MARK: Main

    func testSuperclass() {
        XCTAssert(panGestureRecognizer as Any is UIPanGestureRecognizer)
    }

    func testInitialTargetType() {
        XCTAssert(panGestureRecognizer.initialTarget is Any?)
    }

    func testInitialTarget() {
        class Target {}
        let target = Target()
        let panGestureRecognizer = PanGestureRecognizer(target: target, action: nil)
        XCTAssert(panGestureRecognizer.initialTarget as? Target === target)
    }

    func testInitialActionType() {
        XCTAssert(panGestureRecognizer.initialAction as Any? is Selector?)
    }

    func testInitialAction1() {
        let action = Selector(("panGestureAction1"))
        let panGestureRecognizer = PanGestureRecognizer(target: nil, action: action)
        XCTAssertEqual(panGestureRecognizer.initialAction, action)
    }

    func testInitialAction2() {
        let action = Selector(("panGestureAction2"))
        let panGestureRecognizer = PanGestureRecognizer(target: nil, action: action)
        XCTAssertEqual(panGestureRecognizer.initialAction, action)
    }

}
