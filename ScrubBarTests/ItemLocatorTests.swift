import XCTest
@testable import ScrubBar

final class DefaultItemLocatorTests: XCTestCase {
    
    lazy var itemLocator = DefaultItemLocator(numberOfSegments: 10, boundsWidth: 100)!

    func testIndexOfSegment1() { testIndexOfSegment(withX: 15, expectedIndex: 1) }
    func testIndexOfSegment2() { testIndexOfSegment(withX: 25, expectedIndex: 2) }
    func testIndexOfSegment3() { testIndexOfSegment(withX: 100, expectedIndex: 9) }
    func testIndexOfSegment4() { testIndexOfSegment(withX: -100, expectedIndex: 0) }

    func testIndexOfSegment(withX x: CGFloat, expectedIndex: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(itemLocator.indexOfSegment(forX: x), expectedIndex, file: file, line: line)
    }

    func testInitWithZeroSegments() {
        XCTAssertNil(DefaultItemLocator(numberOfSegments: 0, boundsWidth: 100))
    }

    func testInitWithNegativeSegments() {
        XCTAssertNil(DefaultItemLocator(numberOfSegments: -1, boundsWidth: 100))
    }

    func testInitWithZeroWidth() {
        XCTAssertNil(DefaultItemLocator(numberOfSegments: 1, boundsWidth: 0))
    }

    func testInitWithNegativeWidth() {
        XCTAssertNil(DefaultItemLocator(numberOfSegments: 1, boundsWidth: -1))
    }

}
