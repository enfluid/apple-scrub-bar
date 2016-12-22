import XCTest
@testable import ScrubBar

class ScrubBarTests: XCTestCase {

    lazy var scrubBar = ScrubBar(images: Array(repeating: UIImage(), count: 3))

    // MARK: Main

    func testSuperclass() {
        XCTAssert(scrubBar as Any is UIControl)
    }

    func testUnarchiving() {
        let scrubBar = ScrubBar(coder: .empty)
        XCTAssertNil(scrubBar)
    }

    func testFrame() {
        XCTAssertEqual(scrubBar.frame, .zero)
    }

    func testSubviews() {
        XCTAssertEqual(scrubBar.subviews, [scrubBar.selectionView, scrubBar.stackView])
    }

    // MARK: Stack view

    func testStackViewType() {
        XCTAssert(scrubBar.stackView as Any is UIStackView)
    }

    func testStackViewIsUserInteractionEnabledFalse() {
        XCTAssertFalse(scrubBar.stackView.isUserInteractionEnabled)
    }

    func testStackViewEqualDistribution() {
        XCTAssertEqual(scrubBar.stackView.distribution, .fillEqually)
    }

    func testStackViewArrangedSubviews() {
        XCTAssertEqual(scrubBar.stackView.arrangedSubviews, scrubBar.imageViews)
    }

    func testStackViewIgnoresAutoresizingMask() {
        XCTAssertFalse(scrubBar.stackView.translatesAutoresizingMaskIntoConstraints)
    }

    func testStackViewTopConstraint() {
        let expectedConstraint = scrubBar.stackView.topAnchor.constraint(equalTo: scrubBar.topAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar)
    }

    func testStackViewLeadingConstraint() {
        let expectedConstraint = scrubBar.stackView.leadingAnchor.constraint(equalTo: scrubBar.leadingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar)
    }

    func testStackViewBottomConstraint() {
        let expectedConstraint = scrubBar.stackView.bottomAnchor.constraint(equalTo: scrubBar.bottomAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar)
    }

    func testStackViewTrailingConstraint() {
        let expectedConstraint = scrubBar.stackView.trailingAnchor.constraint(equalTo: scrubBar.trailingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar)
    }

    // MARK: UIImageViews

    func testImageViewsType() {
        XCTAssertTrue(scrubBar.imageViews as Any is [UIImageView])
    }

    func testImageViewCount1() {
        let scrubBar = ScrubBar(images: [UIImage()])
        XCTAssertEqual(scrubBar.imageViews.count, 1)
    }

    func testImageViewCount2() {
        let scrubBar = ScrubBar(images: [UIImage(), UIImage()])
        XCTAssertEqual(scrubBar.imageViews.count, 2)
    }

    func testImageViewsImage1() {
        let image = UIImage()
        let scrubBar = ScrubBar(images: [image, UIImage()])
        XCTAssertEqual(scrubBar.imageViews.first?.image, image)
    }

    func testImageViewsImage2() {
        let image = UIImage()
        let scrubBar = ScrubBar(images: [UIImage(), image])
        XCTAssertEqual(scrubBar.imageViews.last?.image, image)
    }

    func testImageViewsContentMode1() {
        let scrubBar = ScrubBar(images: [UIImage(), UIImage()])
        XCTAssertEqual(scrubBar.imageViews.first?.contentMode, .center)
    }

    func testImageViewsContentMode2() {
        let scrubBar = ScrubBar(images: [UIImage(), UIImage()])
        XCTAssertEqual(scrubBar.imageViews.last?.contentMode, .center)
    }

    func testImageViewsIsAccessibilityElement1() {
        let scrubBar = ScrubBar(images: [UIImage(), UIImage()])
        XCTAssertTrue(scrubBar.imageViews.first?.isAccessibilityElement)
    }

    func testImageViewsIsAccessibilityElement2() {
        let scrubBar = ScrubBar(images: [UIImage(), UIImage()])
        XCTAssertTrue(scrubBar.imageViews.last?.isAccessibilityElement)
    }

    func testImageViewsAccessibilityTraits1() {
        let scrubBar = ScrubBar(images: [UIImage(), UIImage()])
        XCTAssertEqual(scrubBar.imageViews.first?.accessibilityTraits, UIAccessibilityTraitButton)
    }

    func testImageViewsAccessibilityTraits2() {
        let scrubBar = ScrubBar(images: [UIImage(), UIImage()])
        XCTAssertEqual(scrubBar.imageViews.last?.accessibilityTraits, UIAccessibilityTraitButton)
    }

    // MARK: Selected segment

    func testSelectedSegmentType() {
        XCTAssert(scrubBar.selectedSegment as Any is Int)
    }

    func testSelectedSegmentDefault() {
        XCTAssertEqual(scrubBar.selectedSegment, 0)
    }

    // MARK: Selection view

    func testSelectionViewType() {
        XCTAssert(scrubBar.selectionView as Any is UIView)
    }

    func testSelectionViewIsUserInteractionEnabled() {
        XCTAssertFalse(scrubBar.selectionView.isUserInteractionEnabled)
    }

    func testSelectionViewBackgroundColor() {
        XCTAssertEqual(scrubBar.selectionView.backgroundColor, .white)
    }

    func testSelectionViewIgnoresAutoresizingMask() {
        XCTAssertFalse(scrubBar.selectionView.translatesAutoresizingMaskIntoConstraints)
    }

    func testSelectionViewLayerMasksToBounds() {
        XCTAssert(scrubBar.selectionView.layer.masksToBounds)
    }

    func testSelectionViewLayerCornerRadius1() {
        testSelectionViewLayerCornerRadius(withStackViewHeight: 10)
    }

    func testSelectionViewLayerCornerRadius2() {
        testSelectionViewLayerCornerRadius(withStackViewHeight: 20)
    }

    func testSelectionViewLayerCornerRadius(withStackViewHeight stackViewHeight: CGFloat, file: StaticString = #file, line: UInt = #line) {
        scrubBar.stackView.bounds.size = CGSize(width: 0, height: stackViewHeight)
        scrubBar.layoutSubviews()
        XCTAssertEqual(scrubBar.selectionView.layer.cornerRadius, stackViewHeight / 2, file: file, line: line)
    }

    func testSelectionViewTopConstraint() {
        let expectedConstraint = scrubBar.selectionView.topAnchor.constraint(equalTo: scrubBar.stackView.topAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar)
    }

    func testSelectionViewBottomConstraint() {
        let expectedConstraint = scrubBar.selectionView.bottomAnchor.constraint(equalTo: scrubBar.stackView.bottomAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar)
    }

    func testSelectionViewWidthConstraint() {
        let expectedConstraint = scrubBar.selectionView.widthAnchor.constraint(equalTo: scrubBar.selectionView.heightAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar.selectionView)
    }

    func testSelectionViewWidthConstraintInScrubMode() {
        scrubBar.isInScrubMode = true
        let expectedConstraint = scrubBar.selectionView.widthAnchor.constraint(equalTo: scrubBar.stackView.widthAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar)
    }

    func testSelectionViewWidthConstraintGetsRemoved() {
        let constraint = scrubBar.selectionView.widthAnchor.constraint(equalTo: scrubBar.selectionView.heightAnchor)
        scrubBar.isInScrubMode = true
        XCTAssertNotConstraint(constraint, inView: scrubBar.selectionView)
    }

    func testSelectionViewCenterXConstraintDefault() {
        let expectedConstraint = scrubBar.selectionView.centerXAnchor.constraint(equalTo: scrubBar.imageViews[0].centerXAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar)
    }

    func testSelectionViewCenterXConstraint1() { testSelectionViewCenterXConstraint(withSelectedSegment: 1) }
    func testSelectionViewCenterXConstraint2() { testSelectionViewCenterXConstraint(withSelectedSegment: 2) }

    func testSelectionViewCenterXConstraint(withSelectedSegment selectedSegment: Int, file: StaticString = #file, line: UInt = #line) {
        scrubBar.selectedSegment = selectedSegment
        let expectedConstraint = scrubBar.selectionView.centerXAnchor.constraint(equalTo: scrubBar.imageViews[selectedSegment].centerXAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar, file: file, line: line)
    }

    func testSelectionViewCenterXConstraintGetsRemoved() {
        let constraint = scrubBar.selectionView.centerXAnchor.constraint(equalTo: scrubBar.imageViews[0].centerXAnchor)
        scrubBar.selectedSegment = 1
        XCTAssertNotConstraint(constraint, inView: scrubBar)
    }

    func testSelectionViewCenterXConstraintInScrubMode1() {
        scrubBar.isInScrubMode = true
        let expectedConstraint = scrubBar.selectionView.centerXAnchor.constraint(equalTo: scrubBar.stackView.centerXAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar)
    }

    func testSelectionViewCenterXConstraintInScrubMode2() {
        // Arrange
        scrubBar.isInScrubMode = true

        // Act
        scrubBar.selectedSegment = 0

        // Assert
        let constraint = scrubBar.selectionView.centerXAnchor.constraint(equalTo: scrubBar.imageViews[0].centerXAnchor)
        XCTAssertNotConstraint(constraint, inView: scrubBar)
    }

    // MARK: Animate selection change

    func testAnimatingType() {
        XCTAssertTrue(scrubBar.animating as Any is Animating.Type)
    }

    func testAnimatingDefault() {
        XCTAssertTrue(scrubBar.animating == UIView.self)
    }

    func testAnimationDurationType() {
        XCTAssertTrue(scrubBar.animationDuration as Any is TimeInterval)
    }

    func testAnimationDurationDefault() {
        XCTAssertEqual(scrubBar.animationDuration, 0.35)
    }

    func testSelectionViewSelectedSegmentAnimationParams1() { testSelectionViewSelectedSegmentAnimationParams(withAnimationDuration: 1) }
    func testSelectionViewSelectedSegmentAnimationParams2() { testSelectionViewSelectedSegmentAnimationParams(withAnimationDuration: 2.5) }

    func testSelectionViewSelectedSegmentAnimationParams(withAnimationDuration animationDuration: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        AnimatingMock.reset()
        scrubBar.animating = AnimatingMock.self
        scrubBar.animationDuration = animationDuration

        // Act
        scrubBar.selectedSegment = 1

        // Assert
        let expectedAnimationConfiguration = AnimatingMock.AnimationConfiguration(duration: animationDuration, delay: 0, dampingRatio: 1, velocity: 0, options: [])
        XCTAssertEqual(AnimatingMock.capturedAnimationConfigurations, [expectedAnimationConfiguration], file: file, line: line)
    }

    func testSelectionViewXAfterSelectedSegmentAnimation1() { testSelectionViewXAfterSelectedSegmentAnimation(withSelectedSegment: 1, numberOfSegments: 3) }
    func testSelectionViewXAfterSelectedSegmentAnimation2() { testSelectionViewXAfterSelectedSegmentAnimation(withSelectedSegment: 2, numberOfSegments: 5) }

    func testSelectionViewXAfterSelectedSegmentAnimation(withSelectedSegment selectedSegment: Int, numberOfSegments: Int, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        AnimatingMock.reset()
        let imageWidth = 40
        let expectedCenterX = CGFloat(imageWidth * selectedSegment + imageWidth / 2)
        let scrubBar = ScrubBar(images: Array(repeating: UIImage(), count: numberOfSegments))
        scrubBar.frame = CGRect(x: 0, y: 0, width: imageWidth * numberOfSegments, height: 30)
        scrubBar.animating = AnimatingMock.self
        let initialSelectionViewCenterX = scrubBar.selectionView.center.x

        // Act
        scrubBar.selectedSegment = selectedSegment
        AnimatingMock.capturedAnimations.first?()

        // Assert
        XCTAssertEqual(initialSelectionViewCenterX, 0, file: file, line: line)
        XCTAssertEqual(scrubBar.selectionView.center.x, expectedCenterX, file: file, line: line)
    }

    func testSelectionViewScrubModeAnimationParams1() { testSelectionViewScrubModeAnimationParams(withAnimationDuration: 1) }
    func testSelectionViewScrubModeAnimationParams2() { testSelectionViewScrubModeAnimationParams(withAnimationDuration: 2.5) }

    func testSelectionViewScrubModeAnimationParams(withAnimationDuration animationDuration: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        AnimatingMock.reset()
        scrubBar.animating = AnimatingMock.self
        scrubBar.animationDuration = animationDuration

        // Act
        scrubBar.isInScrubMode = true

        // Assert
        let expectedAnimationConfiguration = AnimatingMock.AnimationConfiguration(duration: animationDuration, delay: 0, dampingRatio: 1, velocity: 0, options: [])
        XCTAssertEqual(AnimatingMock.capturedAnimationConfigurations, [expectedAnimationConfiguration], file: file, line: line)
    }

    func testSelectionViewWidthAfterScrubModeAnimation1() { testSelectionViewWidthAfterScrubModeAnimation(withFrameWidth: 100) }
    func testSelectionViewWidthAfterScrubModeAnimation2() { testSelectionViewWidthAfterScrubModeAnimation(withFrameWidth: 200) }

    func testSelectionViewWidthAfterScrubModeAnimation(withFrameWidth width: CGFloat, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        AnimatingMock.reset()
        scrubBar.frame = CGRect(x: 0, y: 0, width: width, height: 30)
        scrubBar.animating = AnimatingMock.self
        let initialSelectionViewWidth = scrubBar.selectionView.frame.width

        // Act
        scrubBar.isInScrubMode = true
        AnimatingMock.capturedAnimations.first?()

        // Assert
        XCTAssertEqual(initialSelectionViewWidth, 0, file: file, line: line)
        XCTAssertEqual(scrubBar.selectionView.frame.width, width, file: file, line: line)
    }

    // MARK: Start touch location

    func testStartTouchLocationType() {
        XCTAssertTrue(scrubBar.startTouchLocation as Any? is CGPoint?)
    }

    func testStartTouchLocationDefault() {
        XCTAssertNil(scrubBar.startTouchLocation)
    }

    // MARK: Segment locator

    func testSegmentLocatorType() {
        XCTAssertTrue(scrubBar.segmentLocator as Any? is DefaultSegmentLocator?)
    }

    // MARK: Scrub mode

    func testIsInScrubModeType() {
        XCTAssertTrue(scrubBar.isInScrubMode as Any is Bool)
    }

    func testIsInScrubModeDefault() {
        XCTAssertFalse(scrubBar.isInScrubMode)
    }

    // MARK: Minimum pan distance for scrub mode

    func testMinPanDistanceType() {
        XCTAssertTrue(scrubBar.minPanDistance as Any is CGFloat)
    }

    func testMinPanDistanceDefault() {
        XCTAssertEqual(scrubBar.minPanDistance, 10)
    }

    // MARK: Begin tracking

    func testBeginTrackingReturnsTrue() {
        XCTAssertTrue(scrubBar.beginTracking(UITouch(), with: nil))
    }

    func testBeginTrackingSetsStartTouchLocation1() { testBeginTrackingSetsStartTouchLocation(withTouchLocation: CGPoint(x: 10, y: 10)) }
    func testBeginTrackingSetsStartTouchLocation2() { testBeginTrackingSetsStartTouchLocation(withTouchLocation: CGPoint(x: 20, y: 20)) }

    func testBeginTrackingSetsStartTouchLocation(withTouchLocation touchLocation: CGPoint, file: StaticString = #file, line: UInt = #line) {
        let touchStub = TouchStub(location: touchLocation, view: scrubBar)
        _ = scrubBar.beginTracking(touchStub, with: nil)
        XCTAssertEqual(scrubBar.startTouchLocation, touchLocation, file: file, line: line)
    }

    func testBeginTrackingCreatesSegmentLocator1() { testBeginTrackingCreatesSegmentLocator(withNumberOfSegments: 3, boundsWidth: 100) }
    func testBeginTrackingCreatesSegmentLocator2() { testBeginTrackingCreatesSegmentLocator(withNumberOfSegments: 2, boundsWidth: 200) }

    func testBeginTrackingCreatesSegmentLocator(withNumberOfSegments numberOfSegments: Int, boundsWidth: CGFloat, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let scrubBar = ScrubBar(images: Array(repeating: UIImage(), count: numberOfSegments))
        scrubBar.bounds = CGRect(x: 0, y: 0, width: boundsWidth, height: 0)
        scrubBar.SegmentLocatorType = SegmentLocatorMock.self

        // Act
        _ = scrubBar.beginTracking(UITouch(), with: nil)

        // Assert
        let segmentLocatorMock = scrubBar.segmentLocator as! SegmentLocatorMock
        XCTAssertEqual(segmentLocatorMock.boundsWidth, boundsWidth, file: file, line: line)
        XCTAssertEqual(segmentLocatorMock.numberOfSegments, numberOfSegments, file: file, line: line)
    }

    // MARK: Continue tracking

    func testContinueTrackingReturnsTrue() {
        _ = scrubBar.beginTracking(UITouch(), with: nil)
        XCTAssertTrue(scrubBar.continueTracking(UITouch(), with: nil))
    }

    func testContinueWithoutStartTouchLocationReturnsFalse() {
        scrubBar.startTouchLocation = nil
        XCTAssertFalse(scrubBar.continueTracking(UITouch(), with: nil))
    }

    func testIsInScrubModeTrue1() {
        scrubBar.minPanDistance = 2
        testIsInScrubModeWithPan(from: .zero, to: CGPoint(x: scrubBar.minPanDistance, y: 0), expected: true)
    }

    func testIsInScrubModeTrue2() {
        let point1 = CGPoint(x: 100, y: 0)
        let point2 = CGPoint(x: point1.x - scrubBar.minPanDistance, y: 0)
        testIsInScrubModeWithPan(from: point1, to: point2, expected: true)
    }

    func testIsInScrubModeFalse1() {
        testIsInScrubModeWithPan(from: .zero, to: CGPoint(x: scrubBar.minPanDistance - 1, y: 0), expected: false)
    }

    func testIsInScrubModeFalse2() {
        let point1 = CGPoint(x: 100, y: 0)
        let point2 = CGPoint(x: point1.x + 1, y: 0)
        testIsInScrubModeWithPan(from: point1, to: point2, expected: false)
    }

    func testIsInScrubModeWithPan(from point1: CGPoint, to point2: CGPoint, expected expectedIsInScrubMode: Bool, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        scrubBar.bounds = CGRect(x: 0, y: 0, width: 100, height: 0)

        // Act
        _ = scrubBar.beginTracking(TouchStub(location: point1, view: scrubBar), with: nil)
        _ = scrubBar.continueTracking(TouchStub(location: point2, view: scrubBar), with: nil)

        // Assert
        XCTAssertEqual(scrubBar.isInScrubMode, expectedIsInScrubMode, file: file, line: line)
    }

    func testScrubModeStays() {
        // Arrange
        scrubBar.bounds = CGRect(x: 0, y: 0, width: 100, height: 0)

        // Act
        _ = scrubBar.beginTracking(TouchStub(location: .zero, view: scrubBar), with: nil)
        scrubBar.isInScrubMode = true
        _ = scrubBar.continueTracking(TouchStub(location: .zero, view: scrubBar), with: nil)

        // Assert
        XCTAssertTrue(scrubBar.isInScrubMode)
    }

    // MARK: Change active segment with a pan

    func testPanCallsSegmentLocator1() {
        testPanCallsSegmentLocator(withLocation: CGPoint(x: scrubBar.minPanDistance, y: 1))
    }

    func testPanCallsSegmentLocator2() {
        testPanCallsSegmentLocator(withLocation: CGPoint(x: scrubBar.minPanDistance * 20, y: 2))
    }

    func testPanCallsSegmentLocator(withLocation location: CGPoint, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let segmentLocatorMock = SegmentLocatorMock()
        scrubBar.segmentLocator = segmentLocatorMock
        scrubBar.startTouchLocation = .zero
        let touchStub = TouchStub(location: location, view: scrubBar)

        // Act
        _ = scrubBar.continueTracking(touchStub, with: nil)

        // Assert
        XCTAssertEqual(segmentLocatorMock.xCoordinates, [touchStub.location.x], file: file, line: line)
    }

    func testPanDoesNotCallSegmentLocator1() {
        testPanDoesNotCallSegmentLocator(withXDistance: scrubBar.minPanDistance - 1)
    }

    func testPanDoesNotCallSegmentLocator2() {
        scrubBar.minPanDistance = 100
        testPanDoesNotCallSegmentLocator(withXDistance: scrubBar.minPanDistance - 1)
    }

    func testPanDoesNotCallSegmentLocator(withXDistance xDistance: CGFloat, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let segmentLocatorMock = SegmentLocatorMock()
        scrubBar.segmentLocator = segmentLocatorMock
        scrubBar.startTouchLocation = .zero
        let touchStub = TouchStub(location: CGPoint(x: xDistance, y: 0), view: scrubBar)

        // Act
        _ = scrubBar.continueTracking(touchStub, with: nil)

        // Assert
        XCTAssertEqual(segmentLocatorMock.xCoordinates, [], file: file, line: line)
    }

    func testPanCallsActiveSegmentInScrubMode() {
        scrubBar.isInScrubMode = true
        testPanCallsSegmentLocator(withLocation: CGPoint(x: scrubBar.minPanDistance, y: 1))
    }

    func testPanChangesSelection1() { testPanChangesSelection(withSegmentIndex: 1) }
    func testPanChangesSelection2() { testPanChangesSelection(withSegmentIndex: 2) }

    func testPanChangesSelection(withSegmentIndex segmentIndex: Int, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let segmentLocatorStub = SegmentLocatorStub(indexOfSegment: segmentIndex)
        scrubBar.segmentLocator = segmentLocatorStub
        scrubBar.startTouchLocation = .zero
        let panTouch = TouchStub(location: CGPoint(x: scrubBar.minPanDistance, y: 0), view: scrubBar)

        // Act
        _ = scrubBar.continueTracking(panTouch, with: nil)

        // Assert
        XCTAssertEqual(scrubBar.selectedSegment, segmentIndex, file: file, line: line)
    }

    // MARK: End tracking

    func testIsInScrubModeIsFalseAfterEndTracking() {
        scrubBar.isInScrubMode = true
        scrubBar.endTracking(nil, with: nil)
        XCTAssertFalse(scrubBar.isInScrubMode)
    }

    func testEndTrackingWithNilTouch() {
        scrubBar.endTracking(nil, with: nil)
    }

    // MARK: Change active segment with a tap

    func testTapCallsSegmentLocator1() { testTapCallsSegmentLocator(withLocation: CGPoint(x: 0, y: 0)) }
    func testTapCallsSegmentLocator2() { testTapCallsSegmentLocator(withLocation: CGPoint(x: 0, y: 1)) }

    func testTapCallsSegmentLocator(withLocation location: CGPoint, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let segmentLocatorMock = SegmentLocatorMock()
        scrubBar.segmentLocator = segmentLocatorMock
        let endTouch = TouchStub(location: location, view: scrubBar)

        // Act
        scrubBar.endTracking(endTouch, with: nil)

        // Assert
        XCTAssertEqual(segmentLocatorMock.xCoordinates, [endTouch.location.x], file: file, line: line)
    }

    func testTapChangesSelection1() { testTapChangesSelection(withSegmentIndex: 1) }
    func testTapChangesSelection2() { testTapChangesSelection(withSegmentIndex: 2) }

    func testTapChangesSelection(withSegmentIndex segmentIndex: Int, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let segmentLocatorStub = SegmentLocatorStub(indexOfSegment: segmentIndex)
        scrubBar.segmentLocator = segmentLocatorStub

        // Act
        scrubBar.endTracking(TouchStub(location: .zero, view: scrubBar), with: nil)

        // Assert
        XCTAssertEqual(scrubBar.selectedSegment, segmentIndex, file: file, line: line)
    }

    // MARK: Cancel tracking

    func testIsInScrubModeIsFalseAfterCancelTracking() {
        scrubBar.isInScrubMode = true
        scrubBar.cancelTracking(with: nil)
        XCTAssertFalse(scrubBar.isInScrubMode)
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

final class SegmentLocatorMock: SegmentLocator {

    let numberOfSegments: Int
    let boundsWidth: CGFloat

    convenience init() {
        self.init(numberOfSegments: 0, boundsWidth: 0)
    }

    init(numberOfSegments: Int, boundsWidth: CGFloat) {
        self.numberOfSegments = numberOfSegments
        self.boundsWidth = boundsWidth
    }

    var xCoordinates: [CGFloat] = []

    func indexOfSegment(forX x: CGFloat) -> Int {
        xCoordinates.append(x)
        return 0
    }

}

struct SegmentLocatorStub: SegmentLocator {

    let indexOfSegment: Int

    init(indexOfSegment: Int) {
        self.indexOfSegment = indexOfSegment
    }

    init(numberOfSegments: Int, boundsWidth: CGFloat) {
        indexOfSegment = 0
    }

    func indexOfSegment(forX x: CGFloat) -> Int {
        return indexOfSegment
    }

}

class AnimatingMock: Animating {

    struct AnimationConfiguration: Equatable {
        let duration: TimeInterval
        let delay: TimeInterval
        let dampingRatio: CGFloat
        let velocity: CGFloat
        let options: UIViewAnimationOptions
    }

    static var capturedAnimationConfigurations: [AnimationConfiguration] = []
    static var capturedAnimations: [() -> Void] = []

    static func reset() {
        capturedAnimationConfigurations = []
        capturedAnimations = []
    }

    static func animate(withDuration duration: TimeInterval, delay: TimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat, options: UIViewAnimationOptions, animations: @escaping () -> Void, completion: ((Bool) -> Swift.Void)?) {
        let params = AnimationConfiguration(duration: duration, delay: delay, dampingRatio: dampingRatio, velocity: velocity, options: options)
        capturedAnimationConfigurations.append(params)
        capturedAnimations.append(animations)
    }

}

func == (lhs: AnimatingMock.AnimationConfiguration, rhs: AnimatingMock.AnimationConfiguration) -> Bool {
    return String(describing: lhs) == String(describing: rhs)
}
