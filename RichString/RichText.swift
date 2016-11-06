//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation
import UIKit

public protocol RichString {
    func color(_ color: UIColor) -> NSAttributedString
    func bold() -> NSAttributedString
    func font(_ font: UIFont) -> NSAttributedString

    /**
     * Applies the given font size to the attributed string. If no font was set on the
     * attributed string yet, UIFont.systemFont will be assumed.
     * - parameter size: The desired point size of the attributed string.
     * - returns: Attributed string with the given font size attribute.
     */
    func fontSize(_ size: CGFloat) -> NSAttributedString
}
