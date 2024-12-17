import Foundation
import XCTest

@MainActor open class BasePage {
    let app: XCUIApplication

    public init(_ app: XCUIApplication) {
        self.app = app
    }

    public init(_ page: BasePage) {
        app = page.app
    }

    // MARK: - XCUIElement

    /// Function that retrieves an element of type Button
    public func getButton(_ locator: UIElementDescriptor,
                                     timeout: TimeInterval = 10,
                                     in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).buttons[locator.getId()], timeout: timeout)
    }

    /// Function that retrieves an element in the TabBar of type Button
    public func getTabBarButton(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.tabBars.buttons[locator.getId()])
    }

    /// Function that retrieves an element of type TextField
    public func getTextField(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.textFields[locator.getId()])
    }

    /// Function that retrieves an element of type SecureTextField
    public func getSecureTextField(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.secureTextFields[locator.getId()])
    }

    /// Function that retrieves an element of type Text
    public func getStaticText(_ locator: UIElementDescriptor,
                                         timeout: TimeInterval = 10) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: app.staticTexts[locator.getId()], timeout: timeout)
    }

    /// Function that retrieves an element of type Switch
    public func getSwitch(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.switches[locator.getId()].switches.element(boundBy: 0))
    }

    /// Function that retrieves the - element of a Stepper element
    public func getStepperMinusButton(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.steppers[locator.getId()].buttons.element(boundBy: 0))
    }

    /// Function that retrieves the + element of a Stepper element
    public func getStepperPlusButton(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.steppers[locator.getId()].buttons.element(boundBy: 1))
    }

    /// Function that retrieves an element of type Menu
    public func getMenu(_ locator: UIElementDescriptor) throws -> XCUIElement {
        if #available(iOS 16, *) {
            try getStaticText(locator).firstMatch
        } else {
            try getStaticText(locator)
        }
    }

    /// Function that retrieves an element of type NavigationBar
    public func getNavigationBar(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.navigationBars[locator.getId()])
    }

    /// Function that retrieves an element of type Button in the presented keyboard
    public func getKeyboardButton(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.keyboards.buttons[locator.getId()])
    }

    /// Function that retrieves an element of type Alert
    public func getAlert(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.alerts[locator.getId()])
    }

    /// Function that retrieves the title element of a presented Alert
    public func getAlertTitle(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.alerts.element.staticTexts[locator.getId()])
    }

    /// Function to retrieves the first Button of a presented Alert
    public func getAlertButton(index: Int = 0) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.alerts.scrollViews.otherElements.buttons.element(boundBy: index))
    }

    /// Function that retrieves an element of type ActivityIndicator
    public func getActivityIndicator(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.activityIndicators[locator.getId()])
    }

    /// Function that retrieves an element of type PageIndicator
    public func getPageIndicator() throws -> XCUIElement {
        try Wait.waitForExistence(element: app.pageIndicators.element(boundBy: 0))
    }

    /// Function that retrieves an element of type CollectionView
    public func getCollectionView(_ locator: UIElementDescriptor) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.collectionViews[locator.getId()])
    }

    /// Function that retrieves an element of type OtherElement
    public func getOtherElement(_ locator: UIElementDescriptor,
                                           timeout: TimeInterval = 10) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: app.otherElements[locator.getId()], timeout: timeout)
    }

    // MARK: - XCUIElement counts

    /// Function that count the number of elements of type Text
    public func getStaticTextCount(matching locator: UIElementDescriptor) -> Int {
        app.staticTexts.matching(identifier: locator.getId()).count
    }

    /// Function that count the number of elements of type Button
    public func getButtonCount(matching locator: UIElementDescriptor) -> Int {
        app.buttons.matching(identifier: locator.getId()).count
    }

    /// Function that count the number of elements of type OtherElement
    public func getOtherElementsCount(matching locator: UIElementDescriptor) -> Int {
        app.otherElements.matching(identifier: locator.getId()).count
    }

    // MARK: - Navigation elements

    /// Function that retrieves the navigation bar back button element
    public func getBackButton() throws -> XCUIElement {
        try Wait.waitForExistence(element: app.navigationBars.firstMatch.buttons.element(boundBy: 0))
    }

    // MARK: - Utils

    /// Function that swipe down to close a presented screen
    public func swipeDownScreen() throws {
        let element = try Wait.waitForExistence(element: app.children(matching: .window).element(boundBy: 0))
        element.swipeDown(velocity: .fast)
    }

    /// Function that swipe up the screen
    public func swipeUpScreen() throws {
        let element = try Wait.waitForExistence(element: app.children(matching: .window).element(boundBy: 0))
        element.swipeUp(velocity: .fast)
    }
}

public extension XCUIElement {
    @MainActor func getTextFieldClearTextButton() throws -> XCUIElement {
        try Wait.waitForExistence(element: buttons.firstMatch)
    }
}
