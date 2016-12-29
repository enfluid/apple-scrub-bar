import UIKit

public final class ScrubBarItem {

    public init(accessibilityLabel: String, image: UIImage) {
        self.accessibilityLabel = accessibilityLabel
        self.image = image
    }

    public let accessibilityLabel: String
    public let image: UIImage

}
