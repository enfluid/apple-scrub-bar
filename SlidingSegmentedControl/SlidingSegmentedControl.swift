import UIKit

public class SlidingSegmentedControl: UIControl {

    // MARK: Initialization

    public init(images: [UIImage]) {
        buttons = SlidingSegmentedControl.makeButtons(numberOfItems: images.count)
        super.init(frame: .zero)
        initButtons(with: images)
        initStackView()
        initSelectionView()
        initPanGestureRecognizer()
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    public var selectedSegment = 0 {
        didSet {
            updateSelectionViewLeadingConstraint()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        selectionView.layer.cornerRadius = min(stackView.bounds.width, stackView.bounds.height)
    }

    // MARK: Stack view

    let stackView = UIStackView()

    private func initStackView() {
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        buttons.forEach(stackView.addArrangedSubview)
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

    // MARK: Buttons

    let buttons: [UIButton]

    private func initButtons(with images: [UIImage]) {
        buttons.forEach(configureButton)
        zip(buttons, images).forEach { (button, image) in
            button.setImage(image, for: .normal)
        }
    }

    private static func makeButtons(numberOfItems: Int) -> [UIButton] {
        let buttonRange = 0..<numberOfItems
        return buttonRange.map { _ in UIButton() }
    }

    private func configureButton(button: UIButton) {
        button.addTarget(self, action: #selector(SlidingSegmentedControl.buttonTapped(sender:)), for: .touchUpInside)
    }

    func buttonTapped(sender: UIButton) {
        selectedSegment = buttons.index(of: sender)!
    }

    // MARK: Selection view

    let selectionView = UIView()

    func initSelectionView() {
        insertSubview(selectionView, belowSubview: stackView)
        selectionView.layer.masksToBounds = true
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(selectionViewStaticConstraints)
        updateSelectionViewLeadingConstraint()
    }

    private var selectionViewStaticConstraints: [NSLayoutConstraint] {
        return [
            selectionView.topAnchor.constraint(equalTo: stackView.topAnchor),
            selectionView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            selectionView.widthAnchor.constraint(equalTo: buttons[0].widthAnchor)
        ]
    }

    private lazy var selectionViewLeadingConstraint: NSLayoutConstraint = SlidingSegmentedControl.makeSelectionViewLeadingConstraint(slidingSegmentedControl: self)

    private var selectedButton: UIButton {
        return buttons[selectedSegment]
    }

    private func updateSelectionViewLeadingConstraint() {
        selectionViewLeadingConstraint.isActive = false
        selectionViewLeadingConstraint = SlidingSegmentedControl.makeSelectionViewLeadingConstraint(slidingSegmentedControl: self)
        selectionViewLeadingConstraint.isActive = true
    }

    private static func makeSelectionViewLeadingConstraint(slidingSegmentedControl: SlidingSegmentedControl) -> NSLayoutConstraint {
        return slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.selectedButton.leadingAnchor)
    }

    // MARK: Pan gesture recognizer

    func initPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(panGesture:)))
        addGestureRecognizer(panGestureRecognizer)
    }

    func didPan(panGesture: UIGestureRecognizer) {

    }

}
