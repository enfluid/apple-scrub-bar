import XCTest
@testable import SlidingSegmentedControl

class SlidingSegmentedControlTests: XCTestCase {

    lazy var slidingSegmentedControl = SlidingSegmentedControl(numberOfItems: 3)

    // MARK: Main

    func testSuperclass() {
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
        XCTAssertEqual(slidingSegmentedControl.subviews, [slidingSegmentedControl.selectionView, slidingSegmentedControl.stackView])
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
        let numberOfItems = 4
        let slidingSegmentedControl = SlidingSegmentedControl(numberOfItems: numberOfItems)
        XCTAssertEqual(slidingSegmentedControl.buttons.count, numberOfItems)
    }

    func testButtonsCount2() {
        let numberOfItem = 8
        let slidingSegmentedControl = SlidingSegmentedControl(numberOfItems: numberOfItem)
        XCTAssertEqual(slidingSegmentedControl.buttons.count, numberOfItem)
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

    // MARK: Selected segment

    func testSelectedSegmentType() {
        XCTAssert(slidingSegmentedControl.selectedSegment as Any is Int)
    }

    func testSelectedSegmentDefault() {
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, 0)
    }

    // MARK: Selection view

    func testSelectionViewType() {
        XCTAssert(slidingSegmentedControl.selectionView as Any is UIView)
    }

    func testSelectionViewIgnoresAutoresizingMask() {
        XCTAssertFalse(slidingSegmentedControl.selectionView.translatesAutoresizingMaskIntoConstraints)
    }

    func testSelectionViewLayerMasksToBounds() {
        XCTAssert(slidingSegmentedControl.selectionView.layer.masksToBounds)
    }

    func testSelectionViewLayerCornerRadius() {
        let expectedCornerRadius = min(slidingSegmentedControl.stackView.bounds.width, slidingSegmentedControl.stackView.bounds.height)
        XCTAssertEqual(slidingSegmentedControl.selectionView.layer.cornerRadius, expectedCornerRadius)
    }

    func testSelectionViewTopConstraint() {
        slidingSegmentedControl.buttons.enumerated().forEach { (index, button) in
            slidingSegmentedControl.selectedSegment = index
            let expectedConstraint = slidingSegmentedControl.selectionView.topAnchor.constraint(equalTo: button.topAnchor)
            XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
        }
    }

    func testSelectionViewLeadingConstraint() {
        slidingSegmentedControl.buttons.enumerated().forEach { (index, button) in
            slidingSegmentedControl.selectedSegment = index
            let expectedConstraint = slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: button.leadingAnchor)
            XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
        }
    }

    func testSelectionViewBottomConstraint() {
        slidingSegmentedControl.buttons.enumerated().forEach { (index, button) in
            slidingSegmentedControl.selectedSegment = index
            let expectedConstraint = slidingSegmentedControl.selectionView.bottomAnchor.constraint(equalTo: button.bottomAnchor)
            XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
        }
    }

    func testSelectionViewTrailingConstraint() {
        slidingSegmentedControl.buttons.enumerated().forEach { (index, button) in
            slidingSegmentedControl.selectedSegment = index
            let expectedConstraint = slidingSegmentedControl.selectionView.trailingAnchor.constraint(equalTo: button.trailingAnchor)
            XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
        }
    }

    // MARK: Pan gesture

    func testPanGesture() {
        let gestureRecognizers = slidingSegmentedControl.gestureRecognizers ?? []
        XCTAssert(gestureRecognizers.first is UIPanGestureRecognizer)
    }

    // MARK: Set image for segment

    func testSetImageForSegment() {
        slidingSegmentedControl.buttons.enumerated().forEach { (index, button) in
            let image = UIImage()
            slidingSegmentedControl.setImage(image, forSegmentAt: index)
            XCTAssertEqual(button.imageView?.image, image)
        }
    }

    // MARK: Set title for segment

    func testSetTitleForSegment() {
        slidingSegmentedControl.buttons.enumerated().forEach { (index, button) in
            let title = String(index)
            slidingSegmentedControl.setTitle(title, forSegmentAt: index)
            XCTAssertEqual(button.title(for: .normal), title)
        }
    }

}
