import UIKit

public class SlidingSegmentedControl: UIControl {

    // MARK: Initialization

    public init(images: [UIImage]) {
        imageViews = images.map { UIImageView(image: $0) }
        super.init(frame: .zero)
        configureImageViews()
        configureStackView()
        configureSelectionView()
    }

    let imageViews: [UIImageView]

    private func configureImageViews() {
        imageViews.forEach { $0.contentMode = .center }
    }

    required public init?(coder: NSCoder) {
        return nil
    }

    public var selectedSegment = 0 {
        didSet {
            updateSelectionViewCenterXConstraint()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        selectionView.layer.cornerRadius = stackView.bounds.height / 2
    }

    // MARK: Stack view

    let stackView = UIStackView()

    private func configureStackView() {
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageViews.forEach(stackView.addArrangedSubview)
        NSLayoutConstraint.activate(stackViewConstraints)
    }

    private var stackViewConstraints: [NSLayoutConstraint] {
        return [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }

    // MARK: Selection view

    let selectionView = UIView()

    func configureSelectionView() {
        insertSubview(selectionView, belowSubview: stackView)
        selectionView.layer.masksToBounds = true
        selectionView.backgroundColor = .white
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(selectionViewStaticConstraints)
        updateSelectionViewCenterXConstraint()
        updateSelectionViewWidthConstraint()
    }

    private var selectionViewStaticConstraints: [NSLayoutConstraint] {
        return [
            selectionView.topAnchor.constraint(equalTo: stackView.topAnchor),
            selectionView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
        ]
    }

    private func updateSelectionViewCenterXConstraint() {
        // deactivate old constraint
        selectionViewCenterXConstraint?.isActive = false

        let newConstraint = selectionView.centerXAnchor.constraint(equalTo: isInScrubMode ? stackView.centerXAnchor : selectedImageView.centerXAnchor)
        newConstraint.isActive = true
        selectionViewCenterXConstraint = newConstraint
    }

    private var selectionViewCenterXConstraint: NSLayoutConstraint?

    private var selectedImageView: UIImageView {
        return imageViews[selectedSegment]
    }

    private func updateSelectionViewWidthConstraint() {
        selectionViewWidthConstraint?.isActive = false
        let newConstraint = selectionView.widthAnchor.constraint(equalTo: isInScrubMode ? stackView.widthAnchor : selectionView.heightAnchor)
        newConstraint.isActive = true
        selectionViewWidthConstraint = newConstraint
    }

    private var selectionViewWidthConstraint: NSLayoutConstraint?

    // MARK: Touch tracking

    var startTouchLocation: CGPoint?

    lazy var SegmentLocatorType: SegmentLocator.Type = DefaultSegmentLocator.self
    var segmentLocator: SegmentLocator?

    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        startTouchLocation = touch.location(in: self)
        segmentLocator = SegmentLocatorType.init(numberOfSegments: imageViews.count, boundsWidth: bounds.width)
        return true
    }

    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard let touchStartLocation = startTouchLocation else {
            // don't do fatal error, because we can't ensure UIKit always calls beginTracking (though it probably does)
            return false
        }
        let location = touch.location(in: self)
        let panDistance = abs(location.x - touchStartLocation.x)
        if (!isInScrubMode && panDistance >= minPanDistance) {
            isInScrubMode = true
        }
        if isInScrubMode {
            selectedSegment = segmentLocator!.indexOfSegment(forX: location.x)
        }

        return true
    }

    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        // required, but don't know how to test this
        super.endTracking(touch, with: event)

        isInScrubMode = false

        guard let touch = touch else { return }

        selectedSegment = segmentLocator!.indexOfSegment(forX: touch.location(in: self).x)
    }

    // MARK: Scrub mode

    var isInScrubMode = false {
        didSet {
            updateSelectionViewWidthConstraint()
            updateSelectionViewCenterXConstraint()
        }
    }

    var minPanDistance: CGFloat = 10
    
}
