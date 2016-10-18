import UIKit

public class SlidingSegmentedControl: UIControl {

    // MARK: Initialization

    public init(numberOfItems: Int) {
        super.init(frame: .zero)
        initStackView()
        initButtons(number: numberOfItems)
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    let stackView = UIStackView()

    private func initStackView() {
        addSubview(stackView)
    }

    var buttons: [UIButton] = []

    private func initButtons(number: Int) {
        for _ in 0..<number {
            buttons += [UIButton()]
        }
    }
}
