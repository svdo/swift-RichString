//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation
import UIKit

extension NSAttributedString: RichString {
    public func color(_ color: UIColor) -> NSAttributedString {
        let m = makeMutable()
        let r = entireString()
        m.addAttribute(NSForegroundColorAttributeName, value: color, range: r)
        return NSAttributedString(attributedString: m)
    }

    public func backgroundColor(_ color: UIColor) -> NSAttributedString {
        let m = makeMutable()
        let r = entireString()
        m.addAttribute(NSBackgroundColorAttributeName, value: color, range: r)
        return NSAttributedString(attributedString: m)
    }

    public func font(_ font: UIFont) -> NSAttributedString {
        let m = makeMutable()
        let r = entireString()
        m.addAttribute(NSFontAttributeName, value: font, range: r)
        return NSAttributedString(attributedString: m)
    }

    public func bold() -> NSAttributedString {
        let attrs = self.attributes(at: 0, effectiveRange: nil)
        let fontAttrs = attrs.filter { $0.0 == NSFontAttributeName }

        precondition(fontAttrs.count > 0, "making bold requires setting font first")

        let font = fontAttrs[0].1 as? UIFont
        let boldDescriptor = font?.fontDescriptor.withSymbolicTraits(.traitBold)

        precondition(boldDescriptor != nil, "failed to create bold font descriptor")

        let boldFont = UIFont(descriptor: boldDescriptor!, size: 0)
        return self.font(boldFont)
    }

    public func fontSize(_ size: CGFloat) -> NSAttributedString {
        let attrs = self.attributes(at: 0, effectiveRange: nil)
        let fontAttrs = attrs.filter { $0.0 == NSFontAttributeName }
        let font: UIFont
        if fontAttrs.count > 0, let f = fontAttrs[0].1 as? UIFont {
            font = f
        } else {
            font = UIFont.systemFont(ofSize: 0)
        }
        let sizedDescriptor = font.fontDescriptor.withSize(size)
        let sizedFont = UIFont(descriptor: sizedDescriptor, size: 0)
        return self.font(sizedFont)
    }
}

extension NSAttributedString {
    fileprivate func makeMutable() -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }

    fileprivate func entireString() -> NSRange {
        return NSRange(location: 0, length: self.string.characters.count)
    }
}

extension NSAttributedString {
    private var attrs: [String:Any] {
        var range: NSRange = NSRange()
        let attrs = self.attributes(at: 0, effectiveRange: &range)
        assert(range.location == 0)
        assert(range.length == self.length,
            "StringAttributes is intended for strings that have attributes on the whole range")
        return attrs
    }

    public var color: UIColor? {
        return attrs[NSForegroundColorAttributeName] as? UIColor
    }

    public var backgroundColor: UIColor? {
        return attrs[NSBackgroundColorAttributeName] as? UIColor
    }

    public var fontSize: CGFloat? {
        return (attrs[NSFontAttributeName] as? UIFont)?.pointSize
    }
}
