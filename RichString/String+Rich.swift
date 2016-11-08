//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation
import UIKit

protocol NonAttributedString: RichString {
    var rich: RichString { get }
}

extension NonAttributedString {
    public func bold() -> NSAttributedString {
        return rich.bold()
    }

    public func font(_ font: UIFont) -> NSAttributedString {
        return rich.font(font)
    }

    public func fontSize(_ size: CGFloat) -> NSAttributedString {
        return rich.fontSize(size)
    }

    public func color(_ color: UIColor) -> NSAttributedString {
        return rich.color(color)
    }

    public func backgroundColor(_ color: UIColor) -> NSAttributedString {
        return rich.backgroundColor(color)
    }

    public func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        return rich.paragraphStyle(paragraphStyle)
    }

}

extension String: NonAttributedString {
    var rich: RichString {
        return NSAttributedString(string: self)
    }
}

extension NSString: NonAttributedString {
    var rich: RichString {
        return NSAttributedString(string: self as String)
    }
}
