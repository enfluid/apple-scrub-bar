import UIKit

public class SlidingSegmentedControl: UIControl {

    // MARK: Initialization

    public init(numberOfItems: Int) {
        super.init(frame: .zero)
        initButtons(number: numberOfItems)
        initStackView()
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    let stackView = UIStackView()

    private func initStackView() {
        addSubview(stackView)
        buttons.forEach { (button) in
            stackView.addArrangedSubview(button)
        }
    }

    var buttons: [UIButton] = []

    private func initButtons(number: Int) {
        for _ in 0..<number {
            buttons += [UIButton()]
        }
    }
}
