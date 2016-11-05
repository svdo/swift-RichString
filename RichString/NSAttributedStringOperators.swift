//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation

public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let l = NSMutableAttributedString(attributedString: lhs)
    l.append(rhs)
    return NSAttributedString(attributedString: l)
}
