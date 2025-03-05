import Foundation
import XCTest

@MainActor open class BasePage {
    let app: XCUIApplication

    public enum Defaults {
        public static let defaultTimeout: TimeInterval = 10
    }

    public init(_ app: XCUIApplication) {
        self.app = app
    }

    public init(_ page: BasePage) {
        app = page.app
    }

    // MARK: - XCUIElement

    /// Function that retrieves an element of type Button
    public func getButton(_ locator: UIElementDescriptor,
                          timeout: TimeInterval = Defaults.defaultTimeout,
                          in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).buttons[locator.getId()],
                                  timeout: timeout)
    }

    /// Function that retrieves an element in the TabBar of type Button
    public func getTabBarButton(_ locator: UIElementDescriptor,
                                timeout: TimeInterval = Defaults.defaultTimeout,
                                in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).tabBars.buttons[locator.getId()],
                                  timeout: timeout)
    }

    /// Function that retrieves an element of type TextField
    public func getTextField(_ locator: UIElementDescriptor,
                             timeout: TimeInterval = Defaults.defaultTimeout,
                             in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).textFields[locator.getId()],
                                  timeout: timeout)
    }

    /// Function that retrieves an element of type SecureTextField
    public func getSecureTextField(_ locator: UIElementDescriptor,
                                   timeout: TimeInterval = Defaults.defaultTimeout,
                                   in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).secureTextFields[locator.getId()],
                                  timeout: timeout)
    }

    /// Function that retrieves an element of type Text
    public func getStaticText(_ locator: UIElementDescriptor,
                              timeout: TimeInterval = Defaults.defaultTimeout,
                              checkHittable: Bool = false,
                              in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).staticTexts[locator.getId()],
                                  timeout: timeout,
                                  checkHittable: checkHittable)
    }

    /// Function that retrieves an element of type Switch
    public func getSwitch(_ locator: UIElementDescriptor,
                          timeout: TimeInterval = Defaults.defaultTimeout,
                          in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).switches[locator.getId()].switches.element(boundBy: 0),
                                  timeout: timeout)
    }

    /// Function that retrieves the - element of a Stepper element
    public func getStepperMinusButton(_ locator: UIElementDescriptor,
                                      timeout: TimeInterval = Defaults.defaultTimeout,
                                      in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).steppers[locator.getId()].buttons.element(boundBy: 0),
                                  timeout: timeout)
    }

    /// Function that retrieves the + element of a Stepper element
    public func getStepperPlusButton(_ locator: UIElementDescriptor,
                                     timeout: TimeInterval = Defaults.defaultTimeout,
                                     in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).steppers[locator.getId()].buttons.element(boundBy: 1),
                                  timeout: timeout)
    }

    /// Function that retrieves an element of type Menu
    public func getMenu(_ locator: UIElementDescriptor,
                        timeout: TimeInterval = Defaults.defaultTimeout,
                        in element: XCUIElement? = nil) throws -> XCUIElement
    {
        if #available(iOS 16, *) {
            try getStaticText(locator, timeout: timeout, in: element).firstMatch
        } else {
            try getStaticText(locator, timeout: timeout, in: element)
        }
    }

    /// Function that retrieves an element of type NavigationBar
    public func getNavigationBar(_ locator: UIElementDescriptor,
                                 timeout: TimeInterval = Defaults.defaultTimeout) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: app.navigationBars[locator.getId()],
                                  timeout: timeout)
    }

    /// Function that retrieves an element of type Button in the presented keyboard
    public func getKeyboardButton(_ locator: UIElementDescriptor,
                                  timeout: TimeInterval = Defaults.defaultTimeout,
                                  in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).keyboards.buttons[locator.getId()],
                                  timeout: timeout)
    }

    /// Function that retrieves an element of type Alert
    public func getAlert(_ locator: UIElementDescriptor,
                         timeout: TimeInterval = Defaults.defaultTimeout) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: app.alerts[locator.getId()],
                                  timeout: timeout)
    }

    /// Function that retrieves the title element of a presented Alert
    public func getAlertTitle(_ locator: UIElementDescriptor,
                              timeout: TimeInterval = Defaults.defaultTimeout,
                              checkHittable: Bool = false) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: app.alerts.element.staticTexts[locator.getId()],
                                  timeout: timeout,
                                  checkHittable: checkHittable)
    }

    /// Function to retrieves the first Button of a presented Alert
    public func getAlertButton(index: Int = 0,
                               timeout: TimeInterval = 10) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: app.alerts.scrollViews.otherElements.buttons.element(boundBy: index),
                                  timeout: timeout)
    }

    /// Function that retrieves an element of type ActivityIndicator
    public func getActivityIndicator(_ locator: UIElementDescriptor,
                                     timeout: TimeInterval = Defaults.defaultTimeout,
                                     in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).activityIndicators[locator.getId()],
                                  timeout: timeout)
    }

    /// Function that retrieves an element of type PageIndicator
    public func getPageIndicator(timeout: TimeInterval = Defaults.defaultTimeout,
                                 in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).pageIndicators.element(boundBy: 0),
                                  timeout: timeout)
    }

    /// Function that retrieves an element of type CollectionView
    public func getCollectionView(_ locator: UIElementDescriptor,
                                  timeout: TimeInterval = Defaults.defaultTimeout,
                                  in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).collectionViews[locator.getId()],
                                  timeout: timeout)
    }

    /// Function that retrieves an element of type OtherElement
    public func getOtherElement(_ locator: UIElementDescriptor,
                                timeout: TimeInterval = Defaults.defaultTimeout,
                                in element: XCUIElement? = nil) throws -> XCUIElement
    {
        try Wait.waitForExistence(element: (element ?? app).otherElements[locator.getId()],
                                  timeout: timeout)
    }

    // MARK: - XCUIElement counts

    /// Function that count the number of elements of type Text
    public func getStaticTextCount(matching locator: UIElementDescriptor,
                                   in element: XCUIElement? = nil) -> Int
    {
        (element ?? app).staticTexts.matching(identifier: locator.getId()).count
    }

    /// Function that count the number of elements of type Button
    public func getButtonCount(matching locator: UIElementDescriptor,
                               in element: XCUIElement? = nil) -> Int
    {
        (element ?? app).buttons.matching(identifier: locator.getId()).count
    }

    /// Function that count the number of elements of type OtherElement
    public func getOtherElementsCount(matching locator: UIElementDescriptor,
                                      in element: XCUIElement? = nil) -> Int
    {
        (element ?? app).otherElements.matching(identifier: locator.getId()).count
    }

    // MARK: - Navigation elements

    /// Function that retrieves the navigation bar back button element
    public func getBackButton(timeout: TimeInterval = Defaults.defaultTimeout) throws -> XCUIElement {
        try Wait.waitForExistence(element: app.navigationBars.firstMatch.buttons.element(boundBy: 0),
                                  timeout: timeout)
    }

    // MARK: - Utils

    /// Function that swipe down to close a presented screen
    public func swipeDownScreen(timeout: TimeInterval = Defaults.defaultTimeout) throws {
        let element = try Wait.waitForExistence(element: app.children(matching: .window).element(boundBy: 0),
                                                timeout: timeout)
        element.swipeDown(velocity: .fast)
    }

    /// Function that swipe up the screen
    public func swipeUpScreen(timeout: TimeInterval = Defaults.defaultTimeout) throws {
        let element = try Wait.waitForExistence(element: app.children(matching: .window).element(boundBy: 0),
                                                timeout: timeout)
        element.swipeUp(velocity: .fast)
    }
}

public extension XCUIElement {
    @MainActor func getTextFieldClearTextButton(
        timeout: TimeInterval = BasePage.Defaults.defaultTimeout
    ) throws -> XCUIElement {
        try Wait.waitForExistence(element: buttons.firstMatch, timeout: timeout)
    }
}
