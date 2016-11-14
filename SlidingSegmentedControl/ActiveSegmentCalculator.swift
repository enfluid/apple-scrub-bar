protocol ActiveSegmentCalculator {
    init(numberOfElements: Int, elementWidth: CGFloat, boundsWidth: CGFloat)
    func indexOfActiveSegment(forTouchLocation touchLocation: CGPoint) -> Int
}

struct DefaultActiveSegmentCalculator: ActiveSegmentCalculator {

    internal init(numberOfElements: Int, elementWidth: CGFloat, boundsWidth: CGFloat) {
    }

    func indexOfActiveSegment(forTouchLocation touchLocation: CGPoint) -> Int {
        return 0
    }

}
