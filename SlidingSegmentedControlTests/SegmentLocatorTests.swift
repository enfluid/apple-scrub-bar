import XCTest
@testable import SlidingSegmentedControl

class SegmentLocatorTests: XCTestCase {
    lazy var segmentLocator = DefaultSegmentLocator(numberOfSegments: 10, boundsWidth: 100)!

    func testIndexOfSegment1() { testIndexOfSegment(withX: 15, expectedIndex: 1) }
    func testIndexOfSegment2() { testIndexOfSegment(withX: 25, expectedIndex: 2) }
    func testIndexOfSegment3() { testIndexOfSegment(withX: 100, expectedIndex: 9) }

    func testIndexOfSegment(withX x: CGFloat, expectedIndex: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(segmentLocator.indexOfSegment(forX: x), expectedIndex)
    }

    func testInitWithZeroSegments() {
        XCTAssertNil(DefaultSegmentLocator(numberOfSegments: 0, boundsWidth: 100))
    }

    func testInitWithNegativeSegments() {
        XCTAssertNil(DefaultSegmentLocator(numberOfSegments: -1, boundsWidth: 100))
    }

    func testInitWithZeroWidth() {
        XCTAssertNil(DefaultSegmentLocator(numberOfSegments: 1, boundsWidth: 0))
    }

    func testInitWithNegativeWidth() {
        XCTAssertNil(DefaultSegmentLocator(numberOfSegments: 1, boundsWidth: -1))
    }

}
