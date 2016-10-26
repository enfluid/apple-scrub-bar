import UIKit

public class SlidingSegmentedControl: UIControl {

    // MARK: Initialization

    public init(numberOfItems: Int) {
        buttons = SlidingSegmentedControl.makeButtons(numberOfItems: numberOfItems)
        super.init(frame: .zero)
        buttons.forEach(configureButton)
        initStackView()
        initSelectionView()
        initPanGestureRecognizer()
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    var selectedSegment = 0 {
        didSet {
            updateLayoutConstraints()
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
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)]
    }

    // MARK: Buttons

    let buttons: [UIButton]

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
        let constraints = [
            selectionView.topAnchor.constraint(equalTo: stackView.topAnchor),
            selectionView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            selectionView.widthAnchor.constraint(equalTo: buttons[0].widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        updateLayoutConstraints()
    }

    private lazy var selectionViewLeadingConstraint: NSLayoutConstraint = SlidingSegmentedControl.makeSelectionViewLeadingConstraint(slidingSegmentedControl: self)

    private var selectedButton: UIButton {
        return buttons[selectedSegment]
    }

    private static func makeSelectionViewLeadingConstraint(slidingSegmentedControl: SlidingSegmentedControl) -> NSLayoutConstraint {
        return slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.selectedButton.leadingAnchor)
    }

    private func updateLayoutConstraints() {
        selectionViewLeadingConstraint.isActive = false
        selectionViewLeadingConstraint = SlidingSegmentedControl.makeSelectionViewLeadingConstraint(slidingSegmentedControl: self)
        selectionViewLeadingConstraint.isActive = true
    }

    // MARK: Pan gesture recognizer

    func initPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(panGesture:)))
        addGestureRecognizer(panGestureRecognizer)
    }

    func didPan(panGesture: UIGestureRecognizer) {

    }

    // MARK: Set image for segment

    func setImage(_ image: UIImage?, forSegmentAt index: Int) {
        buttons[index].setImage(image, for: .normal)
    }

}
