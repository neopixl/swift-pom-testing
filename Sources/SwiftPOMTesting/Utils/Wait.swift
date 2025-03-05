import Foundation
import XCTest

public enum Wait {
    enum ElementError: Error {
        case notFound(_ element: XCUIElement)
        case notHittable(_ element: XCUIElement)
    }

    /// Function that checks during a predefines time if an element exists or not
    @MainActor static func waitForExistence(element: XCUIElement, timeout: TimeInterval) throws -> XCUIElement {
        // Check if the element already exists (faster than waiting for existence)
        guard !(element.exists && element.isHittable) else {
            print("Element \(element.identifier) exists")
            return element
        }

        // If not, wait for it until timeout
        guard element.waitForExistence(timeout: timeout) else {
            print(
                "Element did not appear within the timeout.\n You can see more information of the element here:\n",
                element.debugDescription
            )
            throw ElementError.notFound(element)
        }

        // Chech if element is hittable
        guard element.isHittable else {
            print("Element \(element.identifier) exist, but is not hittable.")
            throw ElementError.notHittable(element)
        }

        print("Element", element.identifier, "appears")
        return element
    }
}
