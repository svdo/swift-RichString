//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation

public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let l = lhs.mutableCopy() as! NSMutableAttributedString
    l.append(rhs)
    return l
}
