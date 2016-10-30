import XCTest
@testable import SlidingSegmentedControl

class SlidingSegmentedControlTests: XCTestCase {

    lazy var slidingSegmentedControl = SlidingSegmentedControl(images: Array(repeating: UIImage(), count: 3))

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

    func testStackViewEqualDistribution() {
        XCTAssertEqual(slidingSegmentedControl.stackView.distribution, .fillEqually)
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
        let numberOfItems = 1
        let images = Array(repeating: UIImage(), count: numberOfItems)
        let slidingSegmentedControl = SlidingSegmentedControl(images: images)
        XCTAssertEqual(slidingSegmentedControl.buttons.count, numberOfItems)
    }

    func testButtonsCount2() {
        let numberOfItems = 2
        let images = Array(repeating: UIImage(), count: numberOfItems)
        let slidingSegmentedControl = SlidingSegmentedControl(images: images)
        XCTAssertEqual(slidingSegmentedControl.buttons.count, numberOfItems)
    }

    func testButtonTouchTarget1() {
        let actions = slidingSegmentedControl.buttons[0].actions(forTarget: slidingSegmentedControl, forControlEvent: .touchUpInside)!
        let expectedAction = String(describing: #selector(SlidingSegmentedControl.buttonTapped(sender:)))
        XCTAssertEqual(actions, [expectedAction])
    }

    func testButtonTouchTarget2() {
        let actions = slidingSegmentedControl.buttons[1].actions(forTarget: slidingSegmentedControl, forControlEvent: .touchUpInside)!
        let expectedAction = String(describing: #selector(SlidingSegmentedControl.buttonTapped(sender:)))
        XCTAssertEqual(actions, [expectedAction])
    }

    func testButtonAction1() {
        let selectedItem = 1
        slidingSegmentedControl.buttonTapped(sender: slidingSegmentedControl.buttons[selectedItem])
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, selectedItem)
    }

    func testButtonAction2() {
        let selectedItem = 2
        slidingSegmentedControl.buttonTapped(sender: slidingSegmentedControl.buttons[selectedItem])
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, selectedItem)
    }

    func testButtonImage1() {
        let image = UIImage()
        let slidingSegmentedControl = SlidingSegmentedControl(images: [image])
        XCTAssertEqual(slidingSegmentedControl.buttons[0].image(for: .normal), image)
    }

    func testButtonImage2() {
        let image = UIImage()
        let slidingSegmentedControl = SlidingSegmentedControl(images: [UIImage(), image])
        XCTAssertEqual(slidingSegmentedControl.buttons[1].image(for: .normal), image)
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

    func testSelectionViewLayerCornerRadiusFromWidth1() {
        let stackViewWidth: CGFloat = 1
        slidingSegmentedControl.stackView.bounds.size = CGSize(width: stackViewWidth, height: stackViewWidth + 1)
        slidingSegmentedControl.layoutSubviews()
        XCTAssertEqual(slidingSegmentedControl.selectionView.layer.cornerRadius, stackViewWidth)
    }

    func testSelectionViewLayerCornerRadiusFromWidth2() {
        let stackViewWidth: CGFloat = 2
        slidingSegmentedControl.stackView.bounds.size = CGSize(width: stackViewWidth, height: stackViewWidth + 1)
        slidingSegmentedControl.layoutSubviews()
        XCTAssertEqual(slidingSegmentedControl.selectionView.layer.cornerRadius, stackViewWidth)
    }

    func testSelectionViewLayerCornerRadiusFromHeight1() {
        let stackViewHeight: CGFloat = 3
        slidingSegmentedControl.stackView.bounds.size = CGSize(width: stackViewHeight + 1, height: stackViewHeight)
        slidingSegmentedControl.layoutSubviews()
        XCTAssertEqual(slidingSegmentedControl.selectionView.layer.cornerRadius, stackViewHeight)
    }

    func testSelectionViewLayerCornerRadiusFromHeight2() {
        let stackViewHeight: CGFloat = 4
        slidingSegmentedControl.stackView.bounds.size = CGSize(width: stackViewHeight + 1, height: stackViewHeight)
        slidingSegmentedControl.layoutSubviews()
        XCTAssertEqual(slidingSegmentedControl.selectionView.layer.cornerRadius, stackViewHeight)
    }

    func testSelectionViewTopConstraint() {
        let expectedConstraint = slidingSegmentedControl.selectionView.topAnchor.constraint(equalTo: slidingSegmentedControl.stackView.topAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewBottomConstraint() {
        let expectedConstraint = slidingSegmentedControl.selectionView.bottomAnchor.constraint(equalTo: slidingSegmentedControl.stackView.bottomAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewWidthConstraint() {
        let expectedConstraint = slidingSegmentedControl.selectionView.widthAnchor.constraint(equalTo: slidingSegmentedControl.buttons[0].widthAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewLeadingConstraintDefault() {
        let expectedConstraint = slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.buttons[0].leadingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewLeadingConstraintActive1() {
        let selectedSegment = 1
        slidingSegmentedControl.selectedSegment = selectedSegment
        let expectedConstraint = slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.buttons[selectedSegment].leadingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewLeadingConstraintActive2() {
        let selectedSegment = 2
        slidingSegmentedControl.selectedSegment = selectedSegment
        let expectedConstraint = slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.buttons[selectedSegment].leadingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewLeadingConstraintInactive() {
        let previouslySelectedSegment = 0
        slidingSegmentedControl.selectedSegment = previouslySelectedSegment
        slidingSegmentedControl.selectedSegment = 1
        let notExpectedConstraint = slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.buttons[previouslySelectedSegment].leadingAnchor)
        XCTAssertNotConstraint(notExpectedConstraint, inView: slidingSegmentedControl)
    }

    // MARK: Pan gesture

    func testPanGestureType() {
        XCTAssert(slidingSegmentedControl.panGestureRecognizer as Any is PanGestureRecognizer)
    }

    func testPanGestureIsAdded() {
        let gestureRecognizers = slidingSegmentedControl.gestureRecognizers ?? []
        XCTAssertEqual(gestureRecognizers.first, slidingSegmentedControl.panGestureRecognizer)
    }

    func testPanGestureTarget() {
        XCTAssert(slidingSegmentedControl.panGestureRecognizer?.initialTarget as? SlidingSegmentedControl === slidingSegmentedControl)
    }

    func testPanGestureAation() {
        let selector = #selector(SlidingSegmentedControl.didPan(panGesture:))
        XCTAssertEqual(slidingSegmentedControl.panGestureRecognizer?.initialAction, selector)
    }

}
