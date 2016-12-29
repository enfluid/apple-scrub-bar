extension Collection where Indices.Iterator.Element == Index {
    subscript(safe index: Self.Index) -> Self.Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
