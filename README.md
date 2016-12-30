# Scrub Bar

Build status:

| master | develop |
|--------|---------|
| [![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=585be85405e37f01000a9a72&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/585be85405e37f01000a9a72/build/latest?branch=master) | [![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=585be85405e37f01000a9a72&branch=develop&build=latest)](https://dashboard.buddybuild.com/apps/585be85405e37f01000a9a72/build/latest?branch=develop) |

# About

_Scrub Bar_ is a `UIControl` inspired by the Emoji bar in iOS's keyboard. It enables tapping and swiping (_scrubbing_) between Scrub Bar items. Each item is represented by an icon and a label for accessibility.

![Illustrating Gif]
(https://media.giphy.com/media/3o6ZtnGnprhEvJLQGc/giphy.gif)

# Usage

``` Swift
    import ScrubBar

    let emojiScrubBar: ScrubBar = {
        let items: [ScrubBarItem] = [
            ScrubBarItem(accessibilityLabel: "People category", image: #imageLiteral(resourceName: "people-emoji-icon")),
            ScrubBarItem(accessibilityLabel: "Nature category", image: #imageLiteral(resourceName: "nature-emoji-icon")),
            ScrubBarItem(accessibilityLabel: "Food & drink category", image: #imageLiteral(resourceName: "food-drink-emoji-icon")),
            ...
        ]
        return ScrubBar(items: items)!
    }()

    func configureScrubBar() {
        emojiScrubBar.delegate = self
        view.addSubview(emojiScrubBar)
        emojiScrubBar.translatesAutoresizingMaskIntoConstraints = false
        // set constraints
        ...
    }

    // MARK: Scrub bar delegate

    func scrubBar(_ scrubBar: ScrubBar, didSelectItemAt selectedIndex: Int) {
        // logic to change panel or page according to selectedIndex
        ...
    }
 ```
