protocol SegmentLocator {
    init(numberOfSegments: Int, boundsWidth: CGFloat)
    func indexOfSegment(forX x: CGFloat) -> Int
}

struct DefaultSegmentLocator: SegmentLocator {

    internal init(numberOfSegments: Int, boundsWidth: CGFloat) {
    }

    func indexOfSegment(forX x: CGFloat) -> Int {
        return 0
    }

}
