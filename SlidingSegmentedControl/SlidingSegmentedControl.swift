import UIKit

public class SlidingSegmentedControl: UIControl {

    // MARK: Initialization

    public init(numberOfItems: Int) {
        super.init(frame: .zero)
        initStackView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    let stackView = UIStackView()

    private func initStackView() {
        addSubview(stackView)
    }
}
