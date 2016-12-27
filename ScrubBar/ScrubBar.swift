import UIKit

public protocol ScrubBarDelegate: class {

    func scrubBar(_ scrubBar: ScrubBar, didSelectItemAt selectedIndex: Int)

}

public class ScrubBar: UIControl {

    // MARK: Initialization

    public init?(items: [ScrubBarItem]) {
        guard items.count > 0 else { return nil }

        self.items = items
        imageViews = items.map { UIImageView(image: $0.image) }
        super.init(frame: .zero)

        configureImageViews()
        configureStackView()
        configureSelectionView()
    }

    public let items: [ScrubBarItem]

    let imageViews: [UIImageView]

    private func configureImageViews() {
        imageViews.enumerated().forEach { (index, element) in
            element.contentMode = .center
            element.isAccessibilityElement = true
            element.accessibilityTraits = UIAccessibilityTraitButton
            element.accessibilityLabel = items[index].accessibilityLabel
        }
    }

    required public init?(coder: NSCoder) {
        return nil
    }

    public var selectedIndex = 0 {
        didSet {
            guard selectedIndex != oldValue else { return }

            delegate?.scrubBar(self, didSelectItemAt: selectedIndex)
            updateSelectionViewCenterXConstraint()
            animating.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.layoutIfNeeded()
            },
            completion: nil)
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        selectionView.layer.cornerRadius = stackView.bounds.height / 2
    }

    // MARK: Stack view

    let stackView = UIStackView()

    private func configureStackView() {
        addSubview(stackView)
        stackView.isUserInteractionEnabled = false
        stackView.distribution = .fillEqually
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
        selectionView.isUserInteractionEnabled = false
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
        // create new constraint
        let newConstraint = selectionView.centerXAnchor.constraint(equalTo: isInScrubMode ? stackView.centerXAnchor : selectedImageView.centerXAnchor)
        newConstraint.isActive = true
        selectionViewCenterXConstraint = newConstraint
    }

    private var selectionViewCenterXConstraint: NSLayoutConstraint?

    private var selectedImageView: UIImageView {
        return imageViews[selectedIndex]
    }

    private func updateSelectionViewWidthConstraint() {
        selectionViewWidthConstraint?.isActive = false
        let newConstraint = selectionView.widthAnchor.constraint(equalTo: isInScrubMode ? stackView.widthAnchor : selectionView.heightAnchor)
        newConstraint.isActive = true
        selectionViewWidthConstraint = newConstraint
    }

    private var selectionViewWidthConstraint: NSLayoutConstraint?

    // MARK: Selection background color

    public var selectionBackgroundColor = UIColor.white {
        didSet {
            selectionView.backgroundColor = selectionBackgroundColor
        }
    }

    // MARK: Begin tracking

    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        startTouchLocation = touch.location(in: self)
        itemLocator = ItemLocatorType.init(numberOfItems: imageViews.count, boundsWidth: bounds.width)
        return true
    }

    var startTouchLocation: CGPoint?

    var itemLocator: ItemLocator?
    lazy var ItemLocatorType: ItemLocator.Type = DefaultItemLocator.self

    // MARK: Continue tracking

    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard let startTouchLocation = startTouchLocation else {
            // don't do fatal error, because we can't ensure UIKit always calls beginTracking (though it probably does)
            return false
        }
        let location = touch.location(in: self)
        let panDistance = abs(location.x - startTouchLocation.x)
        if (!isInScrubMode && panDistance >= minPanDistance) {
            isInScrubMode = true
        }
        if isInScrubMode {
            selectedIndex = itemLocator!.indexOfItem(forX: location.x)
        }

        return true
    }

    var isInScrubMode = false {
        didSet {
            updateSelectionViewCenterXConstraint()
            updateSelectionViewWidthConstraint()
            animating.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }

    var minPanDistance: CGFloat = 10

    // MARK: End tracking

    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        // required, but don't know how to test this
        super.endTracking(touch, with: event)

        isInScrubMode = false

        guard let touch = touch else { return }

        selectedIndex = itemLocator!.indexOfItem(forX: touch.location(in: self).x)
    }

    // MARK: Cancel tracking

    public override func cancelTracking(with event: UIEvent?) {
        isInScrubMode = false
    }

    // MARK: Animating

    var animating: Animating.Type = UIView.self

    var animationDuration: TimeInterval = 0.35

    // MARK: Delegate

    public weak var delegate: ScrubBarDelegate?

}

protocol Animating {

    static func animate(withDuration duration: TimeInterval, delay: TimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat, options: UIViewAnimationOptions, animations: @escaping () -> Swift.Void, completion: ((Bool) -> Swift.Void)?)

}

extension UIView: Animating {}
