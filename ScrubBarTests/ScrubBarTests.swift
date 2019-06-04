import XCTest
@testable import ScrubBar

final class ScrubBarTests: XCTestCase {

    lazy var scrubBar = ScrubBar(items: Array(repeating: .empty(), count: 3))!

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

    func testInitWithZeroItems() {
        XCTAssertNil(ScrubBar(items: []))
    }

    // MARK: Items

    func testItemsType() {
        XCTAssertTrue(scrubBar.items as Any is [ScrubBarItem])
    }

    func testItemsInit() {
        let items: [ScrubBarItem] = [.empty(), .empty()]
        let scrubBar = ScrubBar(items: items)
        XCTAssertEqual(scrubBar?.items ?? [], items)
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
        let scrubBar = ScrubBar(items: [.empty()])
        XCTAssertEqual(scrubBar?.imageViews.count, 1)
    }

    func testImageViewCount2() {
        let scrubBar = ScrubBar(items: [.empty(), .empty()])
        XCTAssertEqual(scrubBar?.imageViews.count, 2)
    }

    func testImageViewsImage1() {
        let item = ScrubBarItem.empty()
        let scrubBar = ScrubBar(items: [item, .empty()])
        XCTAssertEqual(scrubBar?.imageViews.first?.image, item.image)
    }

    func testImageViewsImage2() {
        let item = ScrubBarItem.empty()
        let scrubBar = ScrubBar(items: [.empty(), item])
        XCTAssertEqual(scrubBar?.imageViews.last?.image, item.image)
    }

    func testImageViewsContentMode1() {
        let scrubBar = ScrubBar(items: [.empty(), .empty()])
        XCTAssertEqual(scrubBar?.imageViews.first?.contentMode, .center)
    }

    func testImageViewsContentMode2() {
        let scrubBar = ScrubBar(items: [.empty(), .empty()])
        XCTAssertEqual(scrubBar?.imageViews.last?.contentMode, .center)
    }

    func testImageViewsIsAccessibilityElement1() {
        let scrubBar = ScrubBar(items: [.empty(), .empty()])
        XCTAssertTrue(scrubBar?.imageViews.first?.isAccessibilityElement)
    }

    func testImageViewsIsAccessibilityElement2() {
        let scrubBar = ScrubBar(items: [.empty(), .empty()])
        XCTAssertTrue(scrubBar?.imageViews.last?.isAccessibilityElement)
    }

    func testImageViewsInitialAccessibilityTraits() {
        let scrubBar = ScrubBar(items: [.empty(), .empty(), .empty()])!
        XCTAssertEqual(scrubBar.imageViews[safe: 0]?.accessibilityTraits, UIAccessibilityTraitButton | UIAccessibilityTraitSelected)
        XCTAssertEqual(scrubBar.imageViews[safe: 1]?.accessibilityTraits, UIAccessibilityTraitButton)
        XCTAssertEqual(scrubBar.imageViews[safe: 2]?.accessibilityTraits, UIAccessibilityTraitButton)
    }

    func testImageViewsAccessibilityTraitsOnSelectedIndexChange1() { testImageViewsAccessibilityTraitsOnSelectedIndexChange(withOldSelectedIndex: 0, newSelectedIndex: 1) }
    func testImageViewsAccessibilityTraitsOnSelectedIndexChange2() { testImageViewsAccessibilityTraitsOnSelectedIndexChange(withOldSelectedIndex: 1, newSelectedIndex: 2) }

    func testImageViewsAccessibilityTraitsOnSelectedIndexChange(withOldSelectedIndex oldSelectedIndex: Int, newSelectedIndex: Int, file: StaticString = #file, line: UInt = #line) {
        let scrubBar = ScrubBar(items: [.empty(), .empty(), .empty()])!
        scrubBar.selectedIndex = oldSelectedIndex
        scrubBar.selectedIndex = newSelectedIndex
        XCTAssertEqual(scrubBar.imageViews[safe: oldSelectedIndex]?.accessibilityTraits, UIAccessibilityTraitButton, file: file, line: line)
        XCTAssertEqual(scrubBar.imageViews[safe: newSelectedIndex]?.accessibilityTraits, UIAccessibilityTraitButton | UIAccessibilityTraitSelected, file: file, line: line)
    }

    func testImageViewsFirstAccessibilityLabel1() { testImageViewsFirstAccessibilityLabel("Abc") }
    func testImageViewsFirstAccessibilityLabel2() { testImageViewsFirstAccessibilityLabel("Xyz") }

    func testImageViewsFirstAccessibilityLabel(_ accessibilityLabel: String, file: StaticString = #file, line: UInt = #line) {
        let item = ScrubBarItem(accessibilityLabel: accessibilityLabel, image: UIImage())
        let scrubBar = ScrubBar(items: [item, .empty()])
        XCTAssertEqual(scrubBar?.imageViews.first?.accessibilityLabel, accessibilityLabel, file: file, line: line)
    }

    func testImageViewsLastAccessibilityLabel1() { testImageViewsLastAccessibilityLabel("Abc") }
    func testImageViewsLastAccessibilityLabel2() { testImageViewsLastAccessibilityLabel("Xyz") }

    func testImageViewsLastAccessibilityLabel(_ accessibilityLabel: String, file: StaticString = #file, line: UInt = #line) {
        let item = ScrubBarItem(accessibilityLabel: accessibilityLabel, image: UIImage())
        let scrubBar = ScrubBar(items: [.empty(), item])
        XCTAssertEqual(scrubBar?.imageViews.last?.accessibilityLabel, accessibilityLabel, file: file, line: line)
    }

    // MARK: Selected index

    func testSelectedIndexType() {
        XCTAssert(scrubBar.selectedIndex as Any is Int)
    }

    func testSelectedIndexDefault() {
        XCTAssertEqual(scrubBar.selectedIndex, 0)
    }

    // MARK: Selection view

    func testSelectionViewType() {
        XCTAssert(scrubBar.selectionView as Any is UIView)
    }

    func testSelectionViewIsUserInteractionEnabled() {
        XCTAssertFalse(scrubBar.selectionView.isUserInteractionEnabled)
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

    func testSelectionViewCenterXConstraint1() { testSelectionViewCenterXConstraint(withSelectedIndex: 1) }
    func testSelectionViewCenterXConstraint2() { testSelectionViewCenterXConstraint(withSelectedIndex: 2) }

    func testSelectionViewCenterXConstraint(withSelectedIndex selectedIndex: Int, file: StaticString = #file, line: UInt = #line) {
        scrubBar.selectedIndex = selectedIndex
        let expectedConstraint = scrubBar.selectionView.centerXAnchor.constraint(equalTo: scrubBar.imageViews[selectedIndex].centerXAnchor)
        XCTAssertConstraint(expectedConstraint, inView: scrubBar, file: file, line: line)
    }

    func testSelectionViewCenterXConstraintGetsRemoved() {
        let constraint = scrubBar.selectionView.centerXAnchor.constraint(equalTo: scrubBar.imageViews[0].centerXAnchor)
        scrubBar.selectedIndex = 1
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
        scrubBar.selectedIndex = 0

        // Assert
        let constraint = scrubBar.selectionView.centerXAnchor.constraint(equalTo: scrubBar.imageViews[0].centerXAnchor)
        XCTAssertNotConstraint(constraint, inView: scrubBar)
    }

    // MARK: Selection background color

    func testSelectionBackgroundColorType() {
        XCTAssertTrue(scrubBar.selectionBackgroundColor as Any is UIColor)
    }

    func testSelectionBackgroundSolorDefault() {
        XCTAssertEqual(scrubBar.selectionBackgroundColor, .white)
    }

    func testSelectionViewDefaultBackgroundColor() {
        XCTAssertEqual(scrubBar.selectionView.backgroundColor, scrubBar.selectionBackgroundColor)
    }

    func testSelectionBackgroundColorSet1() { testSelectionBackgroundColorSet(withColor: .blue) }
    func testSelectionBackgroundColorSet2() { testSelectionBackgroundColorSet(withColor: .black) }

    func testSelectionBackgroundColorSet(withColor color: UIColor, file: StaticString = #file, line: UInt = #line) {
        scrubBar.selectionBackgroundColor = color
        XCTAssertEqual(scrubBar.selectionView.backgroundColor, color, file: file, line: line)
    }

    // MARK: Item tint color

    func testItemTintColorType() {
        XCTAssertTrue(scrubBar.itemTintColor as Any is UIColor)
    }

    func testItemTintColorDefault() {
        XCTAssertEqual(scrubBar.itemTintColor, .gray)
    }

    func testImageViewsDefaultTintColor() {
        let scrubBar = ScrubBar(items: [.empty(), .empty(), .empty()])!
        scrubBar.selectedIndex = 0
        XCTAssertEqual(scrubBar.imageViews[safe: 1]?.tintColor, scrubBar.itemTintColor)
        XCTAssertEqual(scrubBar.imageViews[safe: 2]?.tintColor, scrubBar.itemTintColor)
    }

    func testItemTintColorSet1() { testItemTintColorSet(with: .red) }
    func testItemTintColorSet2() { testItemTintColorSet(with: .black) }

    func testItemTintColorSet(with color: UIColor, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let scrubBar = ScrubBar(items: [.empty(), .empty(), .empty()])!
        scrubBar.selectedIndex = 0

        // Act
        scrubBar.itemTintColor = color

        // Assert
        XCTAssertEqual(scrubBar.imageViews[safe: 1]?.tintColor, color, file: file, line: line)
        XCTAssertEqual(scrubBar.imageViews[safe: 2]?.tintColor, color, file: file, line: line)
    }

    // MARK: Selected item tint color

    func testSelectedItemTintColorType() {
        XCTAssertTrue(scrubBar.selectedItemTintColor as Any is UIColor)
    }

    func testSelectedItemTintColorDefault() {
        XCTAssertEqual(scrubBar.selectedItemTintColor, .darkGray)
    }

    func testSelectedItemImageViewDefaultTintColor() {
        XCTAssertEqual(scrubBar.imageViews.first?.tintColor, scrubBar.selectedItemTintColor)
    }

    func testSelectedItemTintColorSet1() { testSelectedItemTintColorSet(with: .red, selectedIndex: 0) }
    func testSelectedItemTintColorSet2() { testSelectedItemTintColorSet(with: .green, selectedIndex: 1) }

    func testSelectedItemTintColorSet(with color: UIColor, selectedIndex: Int, file: StaticString = #file, line: UInt = #line) {
        scrubBar.selectedIndex = selectedIndex
        scrubBar.selectedItemTintColor = color
        XCTAssertEqual(scrubBar.imageViews[safe: selectedIndex]?.tintColor, color, file: file, line: line)
    }

    func testSelectedItemTintColorSetOnSelectedIndexChange1() { testSelectedItemTintColorSetOnSelectedIndexChange(with: .red, selectedIndex: 1) }
    func testSelectedItemTintColorSetOnSelectedIndexChange2() { testSelectedItemTintColorSetOnSelectedIndexChange(with: .green, selectedIndex: 2) }

    func testSelectedItemTintColorSetOnSelectedIndexChange(with color: UIColor, selectedIndex: Int, file: StaticString = #file, line: UInt = #line) {
        scrubBar.selectedItemTintColor = color
        scrubBar.selectedIndex = selectedIndex
        XCTAssertEqual(scrubBar.imageViews[safe: selectedIndex]?.tintColor, scrubBar.selectedItemTintColor, file: file, line: line)
    }

    func testSelectedItemTintColorUnsetOnSelectedIndexChange1() { testSelectedItemTintColorUnsetOnSelectedIndexChange(withNewSelectedIndex: 1, oldSelectedIndex: 0, itemTintColor: .red) }
    func testSelectedItemTintColorUnsetOnSelectedIndexChange2() { testSelectedItemTintColorUnsetOnSelectedIndexChange(withNewSelectedIndex: 2, oldSelectedIndex: 1, itemTintColor: .blue) }

    func testSelectedItemTintColorUnsetOnSelectedIndexChange(withNewSelectedIndex newSelectedIndex: Int, oldSelectedIndex: Int, itemTintColor: UIColor, file: StaticString = #file, line: UInt = #line) {
        scrubBar.itemTintColor = itemTintColor
        scrubBar.selectedIndex = oldSelectedIndex
        scrubBar.selectedIndex = newSelectedIndex
        XCTAssertEqual(scrubBar.imageViews[safe: oldSelectedIndex]?.tintColor, scrubBar.itemTintColor, file: file, line: line)
    }

    func testSelectedItemTintColorKeptOnItemTintColorChange1() { testSelectedItemTintColorKeptOnItemTintColorChange(withSelectedIndex: 0, selectedItemTintColor: .black) }
    func testSelectedItemTintColorKeptOnItemTintColorChange2() { testSelectedItemTintColorKeptOnItemTintColorChange(withSelectedIndex: 1, selectedItemTintColor: .blue) }

    func testSelectedItemTintColorKeptOnItemTintColorChange(withSelectedIndex selectedIndex: Int, selectedItemTintColor: UIColor, file: StaticString = #file, line: UInt = #line) {
        scrubBar.selectedIndex = selectedIndex
        scrubBar.selectedItemTintColor = selectedItemTintColor
        scrubBar.itemTintColor = .red
        XCTAssertEqual(scrubBar.imageViews[safe: selectedIndex]?.tintColor, scrubBar.selectedItemTintColor, file: file, line: line)
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

    func testSelectionViewSelectedIndexAnimationParams1() { testSelectionViewSelectedIndexAnimationParams(withAnimationDuration: 1) }
    func testSelectionViewSelectedIndexAnimationParams2() { testSelectionViewSelectedIndexAnimationParams(withAnimationDuration: 2.5) }

    func testSelectionViewSelectedIndexAnimationParams(withAnimationDuration animationDuration: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        AnimatingMock.reset()
        scrubBar.animating = AnimatingMock.self
        scrubBar.animationDuration = animationDuration
        scrubBar.itemLocator = ItemLocatorStub(indexOfItem: 1)

        // Act
        scrubBar.updateSelectedIndexForTouchLocation(.zero)

        // Assert
        let expectedAnimationConfiguration = AnimatingMock.AnimationConfiguration(duration: animationDuration, delay: 0, dampingRatio: 1, velocity: 0, options: [])
        XCTAssertEqual(AnimatingMock.capturedAnimationConfigurations, [expectedAnimationConfiguration], file: file, line: line)
    }

    func testSelectionViewSelectedIndexAnimationDoesNotRunIfSelectedIndexDoesNotChange() {
        // Arrange
        AnimatingMock.reset()
        scrubBar.animating = AnimatingMock.self
        scrubBar.itemLocator = ItemLocatorStub(indexOfItem: 1)
        scrubBar.selectedIndex = 1

        // Act
        scrubBar.updateSelectedIndexForTouchLocation(.zero)

        // Assert
        XCTAssertEqual(AnimatingMock.capturedAnimationConfigurations, [])
    }

    func testSelectionViewXAfterSelectedIndexAnimation1() { testSelectionViewXAfterSelectedIndexAnimation(withSelectedIndex: 1, numberOfItems: 3) }
    func testSelectionViewXAfterSelectedIndexAnimation2() { testSelectionViewXAfterSelectedIndexAnimation(withSelectedIndex: 2, numberOfItems: 5) }

    func testSelectionViewXAfterSelectedIndexAnimation(withSelectedIndex selectedIndex: Int, numberOfItems: Int, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        AnimatingMock.reset()
        let imageWidth = 40
        let expectedCenterX = CGFloat(imageWidth * selectedIndex + imageWidth / 2)
        let scrubBar = ScrubBar(items: Array(repeating: .empty(), count: numberOfItems))
        scrubBar?.frame = CGRect(x: 0, y: 0, width: imageWidth * numberOfItems, height: 30)
        scrubBar?.animating = AnimatingMock.self
        let initialSelectionViewCenterX = scrubBar?.selectionView.center.x
        scrubBar?.itemLocator = ItemLocatorStub(indexOfItem: selectedIndex)

        // Act
        scrubBar?.updateSelectedIndexForTouchLocation(.zero)
        AnimatingMock.capturedAnimations.first?()

        // Assert
        XCTAssertEqual(initialSelectionViewCenterX, 0, file: file, line: line)
        XCTAssertEqual(scrubBar?.selectionView.center.x, expectedCenterX, file: file, line: line)
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

    // MARK: Item locator

    func testItemLocatorType() {
        XCTAssertTrue(scrubBar.itemLocator as Any? is DefaultItemLocator?)
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

    func testBeginTrackingCreatesItemLocator1() { testBeginTrackingCreatesItemLocator(withNumberOfItems: 3, boundsWidth: 100) }
    func testBeginTrackingCreatesItemLocator2() { testBeginTrackingCreatesItemLocator(withNumberOfItems: 2, boundsWidth: 200) }

    func testBeginTrackingCreatesItemLocator(withNumberOfItems numberOfItems: Int, boundsWidth: CGFloat, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let scrubBar = ScrubBar(items: Array(repeating: .empty(), count: numberOfItems))
        scrubBar?.bounds = CGRect(x: 0, y: 0, width: boundsWidth, height: 0)
        scrubBar?.ItemLocatorType = ItemLocatorMock.self

        // Act
        _ = scrubBar?.beginTracking(UITouch(), with: nil)

        // Assert
        let itemLocatorMock = scrubBar?.itemLocator as! ItemLocatorMock
        XCTAssertEqual(itemLocatorMock.boundsWidth, boundsWidth, file: file, line: line)
        XCTAssertEqual(itemLocatorMock.numberOfItems, numberOfItems, file: file, line: line)
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

    // MARK: Change active item with a pan

    func testPanCallsItemLocator1() {
        testPanCallsItemLocator(withLocation: CGPoint(x: scrubBar.minPanDistance, y: 1))
    }

    func testPanCallsItemLocator2() {
        testPanCallsItemLocator(withLocation: CGPoint(x: scrubBar.minPanDistance * 20, y: 2))
    }

    func testPanCallsItemLocator(withLocation location: CGPoint, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let itemLocatorMock = ItemLocatorMock()
        scrubBar.itemLocator = itemLocatorMock
        scrubBar.startTouchLocation = .zero
        let touchStub = TouchStub(location: location, view: scrubBar)

        // Act
        _ = scrubBar.continueTracking(touchStub, with: nil)

        // Assert
        XCTAssertEqual(itemLocatorMock.xCoordinates, [touchStub.location.x], file: file, line: line)
    }

    func testPanDoesNotCallItemLocator1() {
        testPanDoesNotCallItemLocator(withXDistance: scrubBar.minPanDistance - 1)
    }

    func testPanDoesNotCallItemLocator2() {
        scrubBar.minPanDistance = 100
        testPanDoesNotCallItemLocator(withXDistance: scrubBar.minPanDistance - 1)
    }

    func testPanDoesNotCallItemLocator(withXDistance xDistance: CGFloat, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let itemLocatorMock = ItemLocatorMock()
        scrubBar.itemLocator = itemLocatorMock
        scrubBar.startTouchLocation = .zero
        let touchStub = TouchStub(location: CGPoint(x: xDistance, y: 0), view: scrubBar)

        // Act
        _ = scrubBar.continueTracking(touchStub, with: nil)

        // Assert
        XCTAssertEqual(itemLocatorMock.xCoordinates, [], file: file, line: line)
    }

    func testPanAlwaysCallsItemLocatorWhenInScrubMode() {
        scrubBar.isInScrubMode = true
        testPanCallsItemLocator(withLocation: CGPoint(x: scrubBar.minPanDistance - 1, y: 1))
    }

    func testPanChangesSelection1() { testPanChangesSelection(withItemIndex: 1) }
    func testPanChangesSelection2() { testPanChangesSelection(withItemIndex: 2) }

    func testPanChangesSelection(withItemIndex itemIndex: Int, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let itemLocatorStub = ItemLocatorStub(indexOfItem: itemIndex)
        scrubBar.itemLocator = itemLocatorStub
        scrubBar.startTouchLocation = .zero
        let panTouch = TouchStub(location: CGPoint(x: scrubBar.minPanDistance, y: 0), view: scrubBar)

        // Act
        _ = scrubBar.continueTracking(panTouch, with: nil)

        // Assert
        XCTAssertEqual(scrubBar.selectedIndex, itemIndex, file: file, line: line)
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

    // MARK: Change active item with a tap

    func testTapCallsItemLocator1() { testTapCallsItemLocator(withLocation: CGPoint(x: 0, y: 0)) }
    func testTapCallsItemLocator2() { testTapCallsItemLocator(withLocation: CGPoint(x: 0, y: 1)) }

    func testTapCallsItemLocator(withLocation location: CGPoint, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let itemLocatorMock = ItemLocatorMock()
        scrubBar.itemLocator = itemLocatorMock
        let endTouch = TouchStub(location: location, view: scrubBar)

        // Act
        scrubBar.endTracking(endTouch, with: nil)

        // Assert
        XCTAssertEqual(itemLocatorMock.xCoordinates, [endTouch.location.x], file: file, line: line)
    }

    func testTapChangesSelection1() { testTapChangesSelection(withItemIndex: 1) }
    func testTapChangesSelection2() { testTapChangesSelection(withItemIndex: 2) }

    func testTapChangesSelection(withItemIndex itemIndex: Int, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let itemLocatorStub = ItemLocatorStub(indexOfItem: itemIndex)
        scrubBar.itemLocator = itemLocatorStub

        // Act
        scrubBar.endTracking(TouchStub(location: .zero, view: scrubBar), with: nil)

        // Assert
        XCTAssertEqual(scrubBar.selectedIndex, itemIndex, file: file, line: line)
    }

    // MARK: Cancel tracking

    func testIsInScrubModeIsFalseAfterCancelTracking() {
        scrubBar.isInScrubMode = true
        scrubBar.cancelTracking(with: nil)
        XCTAssertFalse(scrubBar.isInScrubMode)
    }

    // MARK: Delegate

    func testDelegateType() {
        XCTAssertTrue(scrubBar.delegate as Any? is ScrubBarDelegate?)
    }

    func testDelegateIsWeak() {
        var delegateMock: ScrubBarDelegate? = ScrubBarDelegateMock()
        scrubBar.delegate = delegateMock
        delegateMock = nil
        XCTAssertNil(scrubBar.delegate)
    }

    func testDelegateIsCalledWhenUpdatingSelectedIndex1() { testDelegateIsCalledWhenUpdatingSelectedIndex(withSelectedIndex: 1) }
    func testDelegateIsCalledWhenUpdatingSelectedIndex2() { testDelegateIsCalledWhenUpdatingSelectedIndex(withSelectedIndex: 2) }

    func testDelegateIsCalledWhenUpdatingSelectedIndex(withSelectedIndex selectedIndex: Int, file: StaticString = #file, line: UInt = #line) {
        let delegateMock = ScrubBarDelegateMock()
        scrubBar.delegate = delegateMock
        scrubBar.itemLocator = ItemLocatorStub(indexOfItem: selectedIndex)
        scrubBar.updateSelectedIndexForTouchLocation(.zero)
        XCTAssertEqual(delegateMock.capturedScrubBars, [scrubBar], file: file, line: line)
        XCTAssertEqual(delegateMock.capturedIndexes, [selectedIndex], file: file, line: line)
    }

    func testDelegateIsNotCalledWhenUpdatingSelectedIndexWithTheSameValue() {
        let delegateMock = ScrubBarDelegateMock()
        scrubBar.delegate = delegateMock
        scrubBar.itemLocator = ItemLocatorStub(indexOfItem: 1)
        scrubBar.selectedIndex = 1
        scrubBar.updateSelectedIndexForTouchLocation(.zero)
        XCTAssertEqual(delegateMock.capturedScrubBars, [])
        XCTAssertEqual(delegateMock.capturedIndexes, [])
    }

    // MARK: Updating selected index

    func testUpdateSelectedIndexForTouchLocationIsCalledWhileScrubbing() {
        let expectCallupdateSelectedIndexForTouchLocation = expectation(description: "updateSelectedIndexForTouchLocation is called")
        scrubBar.updateSelectedIndexForTouchLocation = { location in
            expectCallupdateSelectedIndexForTouchLocation.fulfill()
        }
        scrubBar.isInScrubMode = true
        scrubBar.startTouchLocation = .zero
        _ = scrubBar.continueTracking(TouchStub(location: .zero, view: scrubBar), with: nil)
        wait(for: [expectCallupdateSelectedIndexForTouchLocation], timeout: 0)
    }

    func testUpdateSelectedIndexForTouchLocationIsCalledWhenTouchEnds() {
        let expectCallupdateSelectedIndexForTouchLocation = expectation(description: "updateSelectedIndexForTouchLocation is called")
        scrubBar.updateSelectedIndexForTouchLocation = { location in
            expectCallupdateSelectedIndexForTouchLocation.fulfill()
        }
        let delegateMock = ScrubBarDelegateMock()
        scrubBar.delegate = delegateMock
        scrubBar.itemLocator = ItemLocatorStub(indexOfItem: 1)
        scrubBar.endTracking(TouchStub(location: .zero, view: scrubBar), with: nil)
        wait(for: [expectCallupdateSelectedIndexForTouchLocation], timeout: 0)
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
            XCTFail("View is not equal to \(String(describing: self.view))")
            return .zero
        }
        return location
    }

}

final class ItemLocatorMock: ItemLocator {

    let numberOfItems: Int
    let boundsWidth: CGFloat

    convenience init() {
        self.init(numberOfItems: 0, boundsWidth: 0)
    }

    init(numberOfItems: Int, boundsWidth: CGFloat) {
        self.numberOfItems = numberOfItems
        self.boundsWidth = boundsWidth
    }

    var xCoordinates: [CGFloat] = []

    func indexOfItem(forX x: CGFloat) -> Int {
        xCoordinates.append(x)
        return 0
    }

}

struct ItemLocatorStub: ItemLocator {

    let indexOfItem: Int

    init(indexOfItem: Int) {
        self.indexOfItem = indexOfItem
    }

    init(numberOfItems: Int, boundsWidth: CGFloat) {
        indexOfItem = 0
    }

    func indexOfItem(forX x: CGFloat) -> Int {
        return indexOfItem
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


extension ScrubBarItem {

    static func empty() -> ScrubBarItem {
        return ScrubBarItem(accessibilityLabel: "", image: UIImage())
    }

}

extension ScrubBarItem: Equatable {}

public func == (lhs: ScrubBarItem, rhs: ScrubBarItem) -> Bool {
    return lhs.accessibilityLabel == rhs.accessibilityLabel && lhs.image == rhs.image
}

final class ScrubBarDelegateMock: ScrubBarDelegate {

    var capturedScrubBars: [ScrubBar] = []
    var capturedIndexes: [Int] = []

    func scrubBar(_ scrubBar: ScrubBar, didSelectItemAt selectedIndex: Int) {
        capturedScrubBars.append(scrubBar)
        capturedIndexes.append(selectedIndex)
    }

}
