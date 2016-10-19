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

    func testStackViewArrangedSubviews() {
        XCTAssertEqual(slidingSegmentedControl.stackView.arrangedSubviews, slidingSegmentedControl.buttons)
    }

    func testStackViewIgnoresAutoresizingMask() {
        XCTAssertFalse(slidingSegmentedControl.stackView.translatesAutoresizingMaskIntoConstraints)
    }

    func testStackViewTopConstraint() {
        let expectedConstraint = slidingSegmentedControl.stackView.topAnchor.constraint(equalTo: slidingSegmentedControl.topAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testStackViewLeadingConstraint() {
        let expectedConstraint = slidingSegmentedControl.stackView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.leadingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testStackViewBottomConstraint() {
        let expectedConstraint = slidingSegmentedControl.stackView.bottomAnchor.constraint(equalTo: slidingSegmentedControl.bottomAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testStackViewTrailingConstraint() {
        let expectedConstraint = slidingSegmentedControl.stackView.trailingAnchor.constraint(equalTo: slidingSegmentedControl.trailingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    // MARK: Buttons

    func testButtonsType() {
        XCTAssert(slidingSegmentedControl.buttons as Any is [UIButton])
    }

    func testButtonsCount1() {
        let numberOfButtons = 4
        let slidingSegmentedControl = SlidingSegmentedControl(numberOfItems: numberOfButtons)
        XCTAssertEqual(slidingSegmentedControl.buttons.count, numberOfButtons)
    }

    func testButtonsCount2() {
        let numberOfButtons = 8
        let slidingSegmentedControl = SlidingSegmentedControl(numberOfItems: numberOfButtons)
        XCTAssertEqual(slidingSegmentedControl.buttons.count, numberOfButtons)
    }

    func testButtonTouchTarget() {
        slidingSegmentedControl.buttons.forEach { button in
            let actions = button.actions(forTarget: slidingSegmentedControl, forControlEvent: .touchUpInside) ?? []
            let expectedAction = String(describing:  #selector(SlidingSegmentedControl.buttonTapped(sender:)))
            XCTAssertEqual(actions, [expectedAction])
        }

    }

    func testButtonAction() {
        slidingSegmentedControl.buttons.enumerated().forEach { (index, button) in
            slidingSegmentedControl.buttonTapped(sender: button)
            XCTAssertEqual(slidingSegmentedControl.selectedSegment, index)
        }
    }

    func testNonexistentButtonAction() {
        let selectedSegment = 2
        slidingSegmentedControl.selectedSegment = selectedSegment
        let button = UIButton()
        slidingSegmentedControl.buttonTapped(sender: button)
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, selectedSegment)
    }

    // MARK: Selected segment

    func testSelectedSegmentType() {
        XCTAssert(slidingSegmentedControl.selectedSegment as Any is Int)
    }

    func testSelectedSegmentDefault() {
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, 0)
    }

    func testSetImageForItem() {
        for segmentIndex in 0..<slidingSegmentedControl.buttons.count {
            let image = UIImage()
            slidingSegmentedControl.setImage(image, forSegmentAt: segmentIndex)
            let button = slidingSegmentedControl.buttons[segmentIndex]
            XCTAssertEqual(button.imageView?.image, image)
        }
    }

}
