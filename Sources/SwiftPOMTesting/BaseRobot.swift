import Foundation
import XCTest

open class BaseRobot {
    public let app: XCUIApplication

    /// Constructor initialization.
    public init(_ app: XCUIApplication) {
        self.app = app
    }

    /// Constructor initialization.
    public required init(_ robot: BaseRobot) {
        app = robot.app
    }

    /// Runs an accessibility audit on the current view.
    /// Generates XCTIssue objects for each issue returned by the audit,
    /// and fails the test case by recording each of these issues.
    /// Returns an error if the audit failed to run.
    ///
    /// - Parameters:
    ///   - auditTypes: Set of audit types which which configure what the audit will test for.
    ///   - block: An optional filter can be used to determine whether or not an issue should be recorded.
    /// To prevent an issue from recorded, return true to handle it yourself.
    @available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, *)
    @MainActor @preconcurrency public func performAccessibilityAudit(
        for auditTypes: XCUIAccessibilityAuditType = .all,
        _ issueHandler: ((XCUIElement) throws -> Bool)? = nil
    ) throws {
        try app.performAccessibilityAudit(for: auditTypes) { issue in
            guard let element = issue.element else { return false }
            return try issueHandler?(element) ?? false
        }
    }
}
