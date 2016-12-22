import UIKit

final class ScrubBarItem {

    init(accessibilityLabel: String, image: UIImage) {
        self.accessibilityLabel = accessibilityLabel
        self.image = image
    }

    let accessibilityLabel: String
    let image: UIImage

}
