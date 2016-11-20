//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation

#if SWIFT_PACKAGE
    import AppKit
#endif

/**
 * Concatenates two attributed strings. Has the same behavior as NSMutableAttributedString.append().
 */
public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let l = NSMutableAttributedString(attributedString: lhs)
    l.append(rhs)
    return NSAttributedString(attributedString: l)
}
