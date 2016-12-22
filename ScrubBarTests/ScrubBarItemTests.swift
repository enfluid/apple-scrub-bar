import XCTest
import UIKit
@testable import ScrubBar

final class ScrubBarItemTests: XCTestCase {

    lazy var scrubBarItem = ScrubBarItem(accessibilityLabel: "", image: UIImage())

    // MARK: Accessibility label

    func testAccessibilityLabelType() {
        XCTAssertTrue(scrubBarItem.accessibilityLabel as Any is String)
    }

    func testAccessibilityLabelInit1() { testAccessibilityLabelInit(withAccessibilityLabel: "a") }
    func testAccessibilityLabelInit2() { testAccessibilityLabelInit(withAccessibilityLabel: "b") }

    func testAccessibilityLabelInit(withAccessibilityLabel accessibilityLabel: String, file: StaticString = #file, line: UInt = #line) {
        let scrubBarItem = ScrubBarItem(accessibilityLabel: accessibilityLabel, image: UIImage())
        XCTAssertEqual(scrubBarItem.accessibilityLabel, accessibilityLabel, file: file, line: line)
    }

    // MARK: Image

    func testImageType() {
        XCTAssertTrue(scrubBarItem.image as Any is UIImage)
    }

    func testImageInit() {
        let image = UIImage()
        let scrubBarItem = ScrubBarItem(accessibilityLabel: "", image: image)
        XCTAssertEqual(scrubBarItem.image, image)
    }

}
