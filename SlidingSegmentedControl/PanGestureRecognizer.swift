import UIKit

class PanGestureRecognizer: UIPanGestureRecognizer {

    let initialTarget: Any?
    let initialAction: Selector?

    override init(target: Any?, action: Selector?) {
        initialTarget = target
        initialAction = action
        super.init(target: target, action: action)
    }

}
