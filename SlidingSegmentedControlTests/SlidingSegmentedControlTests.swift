import XCTest
@testable import SlidingSegmentedControl

class SlidingSegmentedControlTests: XCTestCase {

    lazy var slidingSegmentedControl = SlidingSegmentedControl(numberOfItems: 3)

    // MARK: Main

    func testSuperClass() {
        XCTAssert(slidingSegmentedControl as Any is UIControl)
    }

    func testUnarchiving() {
        let slidingSegmentedControl = SlidingSegmentedControl(coder: .empty)
        XCTAssertNil(slidingSegmentedControl)
    }

    func testFrame() {
        XCTAssertEqual(slidingSegmentedControl.frame, .zero)
    }

    func testSubviews() {
        XCTAssertEqual(slidingSegmentedControl.subviews, [slidingSegmentedControl.stackView])
    }

    // MARK: Stack view

    func testStackViewType() {
        XCTAssert(slidingSegmentedControl.stackView as Any is UIStackView)
    }
}
