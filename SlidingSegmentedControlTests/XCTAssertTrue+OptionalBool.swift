import XCTest

func XCTAssertTrue(_ expression: Bool?, file: StaticString = #file, line: UInt = #line) {
    guard let expression = expression else {
        XCTFail("XCTAssertTrue failed: nil is not equal to true", file: file, line: line)
        return
    }
    XCTAssertTrue(expression, "", file: file, line: line)
}
