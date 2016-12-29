import XCTest
@testable import ScrubBar

final class DefaultItemLocatorTests: XCTestCase {
    
    lazy var itemLocator = DefaultItemLocator(numberOfItems: 10, boundsWidth: 100)!

    func testIndexOfItem1() { testIndexOfItem(withX: 15, expectedIndex: 1) }
    func testIndexOfItem2() { testIndexOfItem(withX: 25, expectedIndex: 2) }
    func testIndexOfItem3() { testIndexOfItem(withX: 100, expectedIndex: 9) }
    func testIndexOfItem4() { testIndexOfItem(withX: -100, expectedIndex: 0) }

    func testIndexOfItem(withX x: CGFloat, expectedIndex: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(itemLocator.indexOfItem(forX: x), expectedIndex, file: file, line: line)
    }

    func testInitWithZeroItems() {
        XCTAssertNil(DefaultItemLocator(numberOfItems: 0, boundsWidth: 100))
    }

    func testInitWithNegativeItems() {
        XCTAssertNil(DefaultItemLocator(numberOfItems: -1, boundsWidth: 100))
    }

    func testInitWithZeroWidth() {
        XCTAssertNil(DefaultItemLocator(numberOfItems: 1, boundsWidth: 0))
    }

    func testInitWithNegativeWidth() {
        XCTAssertNil(DefaultItemLocator(numberOfItems: 1, boundsWidth: -1))
    }

}
