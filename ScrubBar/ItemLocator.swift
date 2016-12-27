protocol ItemLocator {

    init?(numberOfItems: Int, boundsWidth: CGFloat)
    func indexOfItem(forX x: CGFloat) -> Int

}

struct DefaultItemLocator: ItemLocator {

    let numberOfItems: Int
    let boundsWidth: CGFloat

    init?(numberOfItems: Int, boundsWidth: CGFloat) {
        guard numberOfItems > 0, boundsWidth > 0 else { return nil }

        self.numberOfItems = numberOfItems
        self.boundsWidth = boundsWidth
    }

    func indexOfItem(forX x: CGFloat) -> Int {
        let itemWidth = boundsWidth / CGFloat(numberOfItems)
        return max(0, min(numberOfItems - 1, Int(x / itemWidth)))
    }

}
