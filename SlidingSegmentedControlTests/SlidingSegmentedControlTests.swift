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
        XCTAssertEqual(slidingSegmentedControl.stackView.arrangedSubviews, slidingSegmentedControl.imageViews)
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

    // MARK: UIImageViews

    func testImageViewsType() {
        XCTAssertTrue(slidingSegmentedControl.imageViews as Any is [UIImageView])
    }

    func testImageViewsImages() {
        let images = [UIImage(), UIImage()]
        let slidingSegmentedControl = SlidingSegmentedControl(images: images)
        XCTAssertEqual(slidingSegmentedControl.imageViews.map {$0.image!}, images)
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
        let expectedConstraint = slidingSegmentedControl.selectionView.widthAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[0].widthAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewLeadingConstraintDefault() {
        let expectedConstraint = slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[0].leadingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewLeadingConstraintActive1() {
        let selectedSegment = 1
        slidingSegmentedControl.selectedSegment = selectedSegment
        let expectedConstraint = slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[selectedSegment].leadingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewLeadingConstraintActive2() {
        let selectedSegment = 2
        slidingSegmentedControl.selectedSegment = selectedSegment
        let expectedConstraint = slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[selectedSegment].leadingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewLeadingConstraintInactive() {
        let previouslySelectedSegment = 0
        slidingSegmentedControl.selectedSegment = previouslySelectedSegment
        slidingSegmentedControl.selectedSegment = 1
        let notExpectedConstraint = slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[previouslySelectedSegment].leadingAnchor)
        XCTAssertNotConstraint(notExpectedConstraint, inView: slidingSegmentedControl)
    }

    // MARK: Change active segment with a tap

    func testActiveSegmentCalculatorType() {
        XCTAssertTrue(slidingSegmentedControl.activeSegmentCalculator as Any is DefaultActiveSegmentCalculator)
    }

    func testTapCallsActiveSegmentCalculator1() {
        testTapCallsActiveSegmentCalculator(withLocation: CGPoint(x: 0, y: 0))
    }

    func testTapCallsActiveSegmentCalculator2() {
        testTapCallsActiveSegmentCalculator(withLocation: CGPoint(x: 0, y: 1))
    }

    func testTapCallsActiveSegmentCalculator(withLocation location: CGPoint, file: StaticString = #file, line: UInt = #line) {
        let activeSegmentCalculatorMock = ActiveSegmentCalculatorMock()
        slidingSegmentedControl.activeSegmentCalculator = activeSegmentCalculatorMock
        let endTouch = TouchStub(location: location, view: slidingSegmentedControl)
        slidingSegmentedControl.endTracking(endTouch, with: nil)
        XCTAssertEqual(activeSegmentCalculatorMock.touchLocations, [endTouch.location], file: file, line: line)
    }

    func testTapChangesSelection1() {
        testTapChangesSelection(withSegmentIndex: 1)
    }

    func testTapChangesSelection2() {
        testTapChangesSelection(withSegmentIndex: 2)
    }

    func testTapChangesSelection(withSegmentIndex segmentIndex: Int, file: StaticString = #file, line: UInt = #line) {
        let activeSegmentCalculatorStub = ActiveSegmentCalculatorStub(indexOfActiveSegment: segmentIndex)
        slidingSegmentedControl.activeSegmentCalculator = activeSegmentCalculatorStub
        slidingSegmentedControl.endTracking(TouchStub(location: .zero, view: slidingSegmentedControl), with: nil)
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, segmentIndex, file: file, line: line)
    }

    func testEndTrackingWithNilTouch() {
        slidingSegmentedControl.endTracking(nil, with: nil)
    }

    // MARK: Change active segment with a pan

    func testContinueTrackingReturnsTrue() {
        _ = slidingSegmentedControl.beginTracking(UITouch(), with: nil)
        XCTAssertTrue(slidingSegmentedControl.continueTracking(UITouch(), with: nil))
    }

    func testPanCallsActiveSegmentCalculator1() {
        testPanCallsActiveSegmentCalculator(withLocation: CGPoint(x: 1, y: 1))
    }

    func testPanCallsActiveSegmentCalculator2() {
        testPanCallsActiveSegmentCalculator(withLocation: CGPoint(x: 2, y: 2))
    }

    func testPanCallsActiveSegmentCalculator(withLocation location: CGPoint, file: StaticString = #file, line: UInt = #line) {
        let activeSegmentCalculatorMock = ActiveSegmentCalculatorMock()
        slidingSegmentedControl.activeSegmentCalculator = activeSegmentCalculatorMock
        let touch = TouchStub(location: location, view: slidingSegmentedControl)
        _ = slidingSegmentedControl.beginTracking(UITouch(), with: nil)
        _ = slidingSegmentedControl.continueTracking(touch, with: nil)
        XCTAssertEqual(activeSegmentCalculatorMock.touchLocations, [touch.location], file: file, line: line)
    }

    func testPanChangesSelection1() {
        testPanChangesSelection(withSegmentIndex: 1)
    }

    func testPanChangesSelection2() {
        testPanChangesSelection(withSegmentIndex: 2)
    }

    func testPanChangesSelection(withSegmentIndex segmentIndex: Int, file: StaticString = #file, line: UInt = #line) {
        let activeSegmentCalculatorStub = ActiveSegmentCalculatorStub(indexOfActiveSegment: segmentIndex)
        slidingSegmentedControl.activeSegmentCalculator = activeSegmentCalculatorStub
        _ = slidingSegmentedControl.beginTracking(UITouch(), with: nil)
        _ = slidingSegmentedControl.continueTracking(UITouch(), with: nil)
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, segmentIndex, file: file, line: line)
    }

    // MARK: Scrub mode

    func testScrubModeType() {
        XCTAssertTrue(slidingSegmentedControl.isInScrubMode as Any is Bool)
    }

    func testScrubModeFalse() {
        XCTAssertFalse(slidingSegmentedControl.isInScrubMode)
    }

    // MARK: Minimum pan distance for scrub mode

    func testMinPanDistanceType() {
        XCTAssertTrue(slidingSegmentedControl.minPanDistance as Any is CGFloat)
    }

    func testDefaultMinPanDistance() {
        XCTAssertEqual(slidingSegmentedControl.minPanDistance, 10)
    }

    func testBeginTrackingReturnsTrue() {
        XCTAssertTrue(slidingSegmentedControl.beginTracking(UITouch(), with: nil))
    }

    func testContinueWithoutBeginReturnsFalse() {
        XCTAssertFalse(slidingSegmentedControl.continueTracking(UITouch(), with: nil))
    }

    func testIsInScrubModeAfterPanTrue1() {
        slidingSegmentedControl.minPanDistance = 2
        testIsInScrubModeWithPan(from: .zero, to: CGPoint(x: slidingSegmentedControl.minPanDistance, y: 0), expected: true)
    }

    func testIsInScrubModeAfterPanTrue2() {
        let point1 = CGPoint(x: 100, y: 0)
        let point2 = CGPoint(x: point1.x - slidingSegmentedControl.minPanDistance, y: 0)
        testIsInScrubModeWithPan(from: point1, to: point2, expected: true)
    }

    func testIsInScrubModeAfterPanFalse1() {
        testIsInScrubModeWithPan(from: .zero, to: CGPoint(x: slidingSegmentedControl.minPanDistance - 1, y: 0), expected: false)
    }

    func testIsInScrubModeAfterPanFalse2() {
        let point1 = CGPoint(x: 100, y: 0)
        let point2 = CGPoint(x: point1.x + 1, y: 0)
        testIsInScrubModeWithPan(from: point1, to: point2, expected: false)
    }

    func testIsInScrubModeWithPan(from point1: CGPoint, to point2: CGPoint, expected expectedIsInScrubMode: Bool, file: StaticString = #file, line: UInt = #line) {
        let startTouch = TouchStub(location: point1, view: slidingSegmentedControl)
        _ = slidingSegmentedControl.beginTracking(startTouch, with: nil)
        let panTouch = TouchStub(location: point2, view: slidingSegmentedControl)
        _ = slidingSegmentedControl.continueTracking(panTouch, with: nil)
        XCTAssertEqual(slidingSegmentedControl.isInScrubMode, expectedIsInScrubMode, file: file, line: line)
    }

    func testIsInScrubModeAfterEndIsFalse() {
        slidingSegmentedControl.isInScrubMode = true
        slidingSegmentedControl.endTracking(nil, with: nil)
        XCTAssertFalse(slidingSegmentedControl.isInScrubMode)
    }

}

class TouchStub: UITouch {

    let location: CGPoint
    let touchView: UIView

    init(location: CGPoint, view: UIView) {
        self.location = location
        self.touchView = view
    }

    override func location(in view: UIView?) -> CGPoint {
        guard view == self.touchView else {
            XCTFail("View is not equal to \(self.view)")
            return .zero
        }
        return location
    }

}

final class ActiveSegmentCalculatorMock: ActiveSegmentCalculator {

    let numberOfElements: Int
    let elementWidth: CGFloat
    let boundsWidth: CGFloat

    convenience init() {
        self.init(numberOfElements: 0, elementWidth: 0, boundsWidth: 0)
    }

    init(numberOfElements: Int, elementWidth: CGFloat, boundsWidth: CGFloat) {
        self.numberOfElements = numberOfElements
        self.elementWidth = elementWidth
        self.boundsWidth = boundsWidth
    }

    var touchLocations: [CGPoint] = []

    func indexOfActiveSegment(forTouchLocation touchLocation: CGPoint) -> Int {
        touchLocations.append(touchLocation)
        return 0
    }

}

struct ActiveSegmentCalculatorStub: ActiveSegmentCalculator {

    let indexOfActiveSegment: Int

    init(indexOfActiveSegment: Int) {
        self.indexOfActiveSegment = indexOfActiveSegment
    }

    init(numberOfElements: Int, elementWidth: CGFloat, boundsWidth: CGFloat) {
        indexOfActiveSegment = 0
    }

    func indexOfActiveSegment(forTouchLocation touchLocation: CGPoint) -> Int {
        return indexOfActiveSegment
    }

}
