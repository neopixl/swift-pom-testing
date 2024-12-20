# Swift POM Testing

This package contains base classes
to be used in the context of POM (Page Object Model) UI testing.

- [Installation](#installation)
- [Usage](#usage)
  - [Using BasePage](#using-basepage)
  - [Using BaseRobot](#using-baserobot)
  - [Writing the tests](#writing-the-tests)

## Installation

Import this package like any other regular SPM package,
and add it to your UITest target.

```swift
.package(url: "https://github.com/neopixl/swift-pom-testing", .upToNextMajor(from: "1.0.0"))
```

## Usage

### Using BasePage

A **Page** is the first building block for POM testing.
It is used to find identifiable UI elements in a specific screen in your app.

Inherit from the `BasePage` class to have access
to multiple UI element accessor methods.

Most methods are expecting a `UIElementDescriptor` as argument,
used to identify the element in the screen.
This can be an enum with a `String` raw value (prefered),
$or directly a `String`,
that usually represents the **accessibility identifier** of the element.

```swift
import SwitfPOMTesting
import XCTest

@MainActor
class MyPage: BasePage {
    enum Locator: String, UIElementDescriptor {
        case newButton = "New"
        case keyboardSaveButton = "Save"
        case pageTitle = "Title"
    }

    func getNewButton() throws -> XCUIElement {
        try getButton(Locator.newButton)
    }

    func getKeyboardSaveButton() throws -> XCUIElement {
        try getKeyboardButton(Locator.keyboardSaveButton)
    }

    func getTitle() throws -> XCUIElement {
        try getStaticText(Locator.pageTitle)
    }
}
```

**Element getter methods**

- `getButton(_:timeout:in:)`
- `getTabBarButton(_:timeout:in:)`
- `getTextField(_:timeout:in:)`
- `getSecureTextField(_:timeout:in:)`
- `getStaticText(_:timeout:in:)`
- `getSwitch(_:timeout:in:)`
- `getStepperMinusButton(_:timeout:in:)`
- `getStepperPlusButton(_:timeout:in:)`
- `getMenu(_:timeout:in:)`
- `getNavigationBar(_:timeout:)`
- `getBackButton(timeout:)`
- `getKeyboardButton(_:timeout:in:)`
- `getAlert(_:timeout:)`
- `getAlertTitle(_:timeout:)`
- `getAlertButton(index:timeout:)`
- `getActivityIndicator(_:timeout:in:)`
- `getPageIndicator(timeout:in:)`
- `getCollectionView(_:timeout:in:)`
- `getOtherElementsCount(_:timeout:in:)`

**Count methods**

- `getStaticTextCount(matching:in:)`
- `getButtonCount(matching:in:)`
- `getOtherElementsCount(matching:in:)`

**Utils methods**

- `swipeDownScreen(timeout:)`
- `swipeUpScreen(timeout:)`

Please note to all those methods will wait for the targeted element
to appear until a given number of seconds,
then throw an error if the element isn't found
(relying on native XCTest `exists` and `waitForExistence` methods).

### Using BaseRobot

A Robot consumes a Page to perform a single action
or verification on the screen, by getting a page element,
and performing an action on it.

Usually, **all Robot methods should return a reference to a Robot**,
in order to simplify method chaining when writing the final test code.

```swift
import SwitfPOMTesting
import XCTest

@MainActor
class MyRobot: BaseRobot {
    let page: MyPage

    required init(_ robot: BaseRobot) {
        page = MyPage(robot.app)
        super.init(robot)
    }

    // MARK: - Actions

    func tapKeyboardSaveButton() -> AnotherRobot {
        let button = try page.getKeyboardSaveButton()
        button.tap()

        return AnotherRobot(self)
    }

    // MARK - Verifications

    func verifyTitle() throws -> Self {
        // Verify the existence of an element by just trying to get it.
        _ = try page.getTitle()

        return self
    }
}
```

### Writing the tests

The final step is to write your test classes,
consuming Robots to chain actions together to test a single feature.

Usually, your tests should chain *action* methods
and end with a final *verification* method.

```swift
import SwiftPOMTesting
import XCTest

@MainActor
final class MyUITests: XCTestCase {
    let app = XCUIApplication()

    // Construct a BaseRobot that will be used
    // to instatiate all Robots
    lazy var baseRobot = BaseRobot(app)

    override public func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = false

        // Use a launchArgument to tell your app
        // you're in UITest mode, that you can intercept with
        // ProcessInfo.processInfo.arguments.contains("UITest")
        app.launchArguments = ["UITest"]
        app.launch()
    }

    func testFeature() async throws {
        try MyRobot(baseRobot)
            .tapNewTeamButton()
            .typeNewTeamName()
            .tapSaveButton()
            .verifyNewTeam()
    }
}
```
