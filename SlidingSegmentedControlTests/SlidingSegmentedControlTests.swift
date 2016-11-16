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

    func testSelectionViewLayerCornerRadius1() {
        testSelectionViewLayerCornerRadius(withStackViewHeight: 10)
    }

    func testSelectionViewLayerCornerRadius2() {
        testSelectionViewLayerCornerRadius(withStackViewHeight: 20)
    }

    func testSelectionViewLayerCornerRadius(withStackViewHeight stackViewHeight: CGFloat, file: StaticString = #file, line: UInt = #line) {
        slidingSegmentedControl.stackView.bounds.size = CGSize(width: 0, height: stackViewHeight)
        slidingSegmentedControl.layoutSubviews()
        XCTAssertEqual(slidingSegmentedControl.selectionView.layer.cornerRadius, stackViewHeight / 2, file: file, line: line)
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
        let expectedConstraint = slidingSegmentedControl.selectionView.widthAnchor.constraint(equalTo: slidingSegmentedControl.selectionView.heightAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl.selectionView)
    }

    func testSelectionViewWidthConstraintInScrubMode() {
        slidingSegmentedControl.isInScrubMode = true
        let expectedConstraint = slidingSegmentedControl.selectionView.widthAnchor.constraint(equalTo: slidingSegmentedControl.stackView.widthAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewWidthConstraintGetsRemoved() {
        let constraint = slidingSegmentedControl.selectionView.widthAnchor.constraint(equalTo: slidingSegmentedControl.selectionView.heightAnchor)
        slidingSegmentedControl.isInScrubMode = true
        XCTAssertNotConstraint(constraint, inView: slidingSegmentedControl.selectionView)
    }

    func testSelectionViewCenterXConstraintDefault() {
        let expectedConstraint = slidingSegmentedControl.selectionView.centerXAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[0].centerXAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewCenterXConstraint1() {
        testSelectionViewCenterXConstraint(withSelectedSegment: 1)
    }

    func testSelectionViewCenterXConstraint2() {
        testSelectionViewCenterXConstraint(withSelectedSegment: 2)
    }

    func testSelectionViewCenterXConstraint(withSelectedSegment selectedSegment: Int, file: StaticString = #file, line: UInt = #line) {
        slidingSegmentedControl.selectedSegment = selectedSegment
        let expectedConstraint = slidingSegmentedControl.selectionView.centerXAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[selectedSegment].centerXAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl, file: file, line: line)
    }

    func testSelectionViewCenterXConstraintGetsRemoved() {
        let constraint = slidingSegmentedControl.selectionView.centerXAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[0].centerXAnchor)
        slidingSegmentedControl.selectedSegment = 0
        slidingSegmentedControl.selectedSegment = 1
        XCTAssertNotConstraint(constraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewCenterXConstraintInScrubMode1() {
        slidingSegmentedControl.isInScrubMode = true
        let expectedConstraint = slidingSegmentedControl.selectionView.centerXAnchor.constraint(equalTo: slidingSegmentedControl.stackView.centerXAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewCenterXConstraintInScrubMode2() {
        slidingSegmentedControl.isInScrubMode = true
        slidingSegmentedControl.selectedSegment = 0
        let constraint = slidingSegmentedControl.selectionView.centerXAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[0].centerXAnchor)
        XCTAssertNotConstraint(constraint, inView: slidingSegmentedControl)
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
        testPanCallsActiveSegmentCalculator(withLocation: CGPoint(x: slidingSegmentedControl.minPanDistance, y: 1))
    }

    func testPanCallsActiveSegmentCalculator2() {
        testPanCallsActiveSegmentCalculator(withLocation: CGPoint(x: slidingSegmentedControl.minPanDistance * 20, y: 2))
    }

    func testPanCallsActiveSegmentCalculator(withLocation location: CGPoint, file: StaticString = #file, line: UInt = #line) {
        let activeSegmentCalculatorMock = ActiveSegmentCalculatorMock()
        slidingSegmentedControl.activeSegmentCalculator = activeSegmentCalculatorMock
        let touch = TouchStub(location: location, view: slidingSegmentedControl)
        _ = slidingSegmentedControl.beginTracking(UITouch(), with: nil)
        _ = slidingSegmentedControl.continueTracking(touch, with: nil)
        XCTAssertEqual(activeSegmentCalculatorMock.touchLocations, [touch.location], file: file, line: line)
    }

    func testPanDoesNotCallActiveSegmentCalculator1() {
        testPanDoesNotCallActiveSegmentCalculator(withXDistance: slidingSegmentedControl.minPanDistance - 1)
    }

    func testPanDoesNotCallActiveSegmentCalculator2() {
        slidingSegmentedControl.minPanDistance = 100
        testPanDoesNotCallActiveSegmentCalculator(withXDistance: slidingSegmentedControl.minPanDistance - 1)
    }

    func testPanDoesNotCallActiveSegmentCalculator(withXDistance xDistance: CGFloat, file: StaticString = #file, line: UInt = #line) {
        let activeSegmentCalculatorMock = ActiveSegmentCalculatorMock()
        slidingSegmentedControl.activeSegmentCalculator = activeSegmentCalculatorMock
        let startTouch = TouchStub(location: .zero, view: slidingSegmentedControl)
        let panTouch = TouchStub(location: CGPoint(x: xDistance, y: 0), view: slidingSegmentedControl)
        _ = slidingSegmentedControl.beginTracking(startTouch, with: nil)
        _ = slidingSegmentedControl.continueTracking(panTouch, with: nil)
        XCTAssertEqual(activeSegmentCalculatorMock.touchLocations, [], file: file, line: line)
    }


    func testPanChangesSelection1() { testPanChangesSelection(withSegmentIndex: 1) }
    func testPanChangesSelection2() { testPanChangesSelection(withSegmentIndex: 2) }

    func testPanChangesSelection(withSegmentIndex segmentIndex: Int, file: StaticString = #file, line: UInt = #line) {
        let activeSegmentCalculatorStub = ActiveSegmentCalculatorStub(indexOfActiveSegment: segmentIndex)
        slidingSegmentedControl.activeSegmentCalculator = activeSegmentCalculatorStub
        _ = slidingSegmentedControl.beginTracking(UITouch(), with: nil)
        let panTouch = TouchStub(location: CGPoint(x: slidingSegmentedControl.minPanDistance, y: 0), view: slidingSegmentedControl)
        _ = slidingSegmentedControl.continueTracking(panTouch, with: nil)
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, segmentIndex, file: file, line: line)
    }

    // MARK: Scrub mode

    func testIsInScrubModeType() {
        XCTAssertTrue(slidingSegmentedControl.isInScrubMode as Any is Bool)
    }

    func testIsInScrubModeDefault() {
        XCTAssertFalse(slidingSegmentedControl.isInScrubMode)
    }

    // MARK: Minimum pan distance for scrub mode

    func testMinPanDistanceType() {
        XCTAssertTrue(slidingSegmentedControl.minPanDistance as Any is CGFloat)
    }

    func testMinPanDistanceDefault() {
        XCTAssertEqual(slidingSegmentedControl.minPanDistance, 10)
    }

    func testBeginTrackingReturnsTrue() {
        XCTAssertTrue(slidingSegmentedControl.beginTracking(UITouch(), with: nil))
    }

    func testContinueWithoutBeginReturnsFalse() {
        XCTAssertFalse(slidingSegmentedControl.continueTracking(UITouch(), with: nil))
    }

    func testIsInScrubModeTrue1() {
        slidingSegmentedControl.minPanDistance = 2
        testIsInScrubModeWithPan(from: .zero, to: CGPoint(x: slidingSegmentedControl.minPanDistance, y: 0), expected: true)
    }

    func testIsInScrubModeTrue2() {
        let point1 = CGPoint(x: 100, y: 0)
        let point2 = CGPoint(x: point1.x - slidingSegmentedControl.minPanDistance, y: 0)
        testIsInScrubModeWithPan(from: point1, to: point2, expected: true)
    }

    func testIsInScrubModeFalse1() {
        testIsInScrubModeWithPan(from: .zero, to: CGPoint(x: slidingSegmentedControl.minPanDistance - 1, y: 0), expected: false)
    }

    func testIsInScrubModeFalse2() {
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

    func testScrubModeStays() {
        let touchStub1 = TouchStub(location: .zero, view: slidingSegmentedControl)
        let touchStub2 = TouchStub(location: CGPoint(x: slidingSegmentedControl.minPanDistance, y: 0), view: slidingSegmentedControl)
        _ = slidingSegmentedControl.beginTracking(touchStub1, with: nil)
        _ = slidingSegmentedControl.continueTracking(touchStub2, with: nil)
        _ = slidingSegmentedControl.continueTracking(touchStub1, with: nil)
        XCTAssertTrue(slidingSegmentedControl.isInScrubMode)
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
