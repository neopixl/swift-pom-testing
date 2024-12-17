import Foundation
import XCTest

/// Generic descriptor to identify an UI Element.
public protocol UIElementDescriptor {
    func getId() -> String
}

/// Specific implementation for enums.
public extension UIElementDescriptor where Self: RawRepresentable, Self.RawValue == String {
    func getId() -> String {
        rawValue
    }
}

/// Specific implementation for String.
extension String: UIElementDescriptor {
    public func getId() -> String {
        self
    }
}

/// Implementation to identify dynamic element displaying live / updatable information.
public struct UIDynamicElementDescriptor: UIElementDescriptor {
    let descriptor: String

    public init(_ descriptor: String) {
        self.descriptor = descriptor
    }

    public func getId() -> String {
        descriptor
    }
}
