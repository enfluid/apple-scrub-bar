protocol ItemLocator {

    init?(numberOfSegments: Int, boundsWidth: CGFloat)
    func indexOfSegment(forX x: CGFloat) -> Int

}

struct DefaultItemLocator: ItemLocator {

    let numberOfSegments: Int
    let boundsWidth: CGFloat

    init?(numberOfSegments: Int, boundsWidth: CGFloat) {
        guard numberOfSegments > 0, boundsWidth > 0 else { return nil }

        self.numberOfSegments = numberOfSegments
        self.boundsWidth = boundsWidth
    }

    func indexOfSegment(forX x: CGFloat) -> Int {
        let segmentWidth = boundsWidth / CGFloat(numberOfSegments)
        return max(0, min(numberOfSegments - 1, Int(x / segmentWidth)))
    }

}
