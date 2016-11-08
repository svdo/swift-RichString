//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation
import UIKit

// MARK: - Simple attributes
extension NSAttributedString: RichString {
    public func color(_ color: UIColor) -> NSAttributedString {
        return addingAttribute(NSForegroundColorAttributeName, value: color)
    }

    public func backgroundColor(_ color: UIColor) -> NSAttributedString {
        return addingAttribute(NSBackgroundColorAttributeName, value: color)
    }

    public func font(_ font: UIFont) -> NSAttributedString {
        return addingAttribute(NSFontAttributeName, value: font)
    }

    public func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        return addingAttribute(NSParagraphStyleAttributeName, value: paragraphStyle)
    }

    public func ligature(_ ligature: Int) -> NSAttributedString {
        return addingAttribute(NSLigatureAttributeName, value: ligature)
    }

    public func kern(_ kern: Float) -> NSAttributedString {
        return addingAttribute(NSKernAttributeName, value: kern)
    }

    public func strikeThrough(style: NSUnderlineStyle) -> NSAttributedString {
        return addingAttribute(NSStrikethroughStyleAttributeName,
                               value: style.rawValue)
    }

    public func underline(style: NSUnderlineStyle) -> NSAttributedString {
        return addingAttribute(NSUnderlineStyleAttributeName,
                               value: style.rawValue)
    }

    public func stroke(width: Float, color: UIColor) -> NSAttributedString {
        return addingAttribute(NSStrokeColorAttributeName,
                               value: color)
            .addingAttribute(NSStrokeWidthAttributeName,
                             value: width)
    }

    public func shadow(_ shadow: NSShadow) -> NSAttributedString {
        return addingAttribute(NSShadowAttributeName, value: shadow)
    }

    public func letterPressed() -> NSAttributedString {
        return addingAttribute(NSTextEffectAttributeName,
                               value: NSTextEffectLetterpressStyle)
    }
}

// MARK: - Font attributes
extension NSAttributedString {
    public func bold() -> NSAttributedString {
        let attrs = self.attributes(at: 0, effectiveRange: nil)
        let fontAttrs = attrs.filter {
            $0.0 == NSFontAttributeName
        }

        precondition(fontAttrs.count > 0, "making bold requires setting font first")

        let font = fontAttrs[0].1 as? UIFont
        let boldDescriptor = font?.fontDescriptor.withSymbolicTraits(.traitBold)

        precondition(boldDescriptor != nil, "failed to create bold font descriptor")

        let boldFont = UIFont(descriptor: boldDescriptor!, size: 0)
        return self.font(boldFont)
    }

    public func fontSize(_ size: CGFloat) -> NSAttributedString {
        let attrs = self.attributes(at: 0, effectiveRange: nil)
        let fontAttrs = attrs.filter {
            $0.0 == NSFontAttributeName
        }

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

// MARK: - Private helpers
extension NSAttributedString {
    fileprivate func addingAttribute(_ name: String, value: Any)
            -> NSAttributedString {
        let m = makeMutable()
        let r = entireString()
        m.addAttribute(name, value: value, range: r)
        return NSAttributedString(attributedString: m)
    }

    fileprivate func makeMutable() -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }

    fileprivate func entireString() -> NSRange {
        return NSRange(location: 0, length: self.string.characters.count)
    }
}

// MARK: - Attribute getters
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

    public var paragraphStyle: NSParagraphStyle? {
        return attrs[NSParagraphStyleAttributeName] as? NSParagraphStyle
    }

    public var ligature: Int? {
        return attrs[NSLigatureAttributeName] as? Int
    }

    public var kern: Float? {
        return attrs[NSKernAttributeName] as? Float
    }

    public var strikeThroughStyle: NSUnderlineStyle? {
        guard let rawValue = attrs[NSStrikethroughStyleAttributeName] as? Int else {
            return nil
        }
        return NSUnderlineStyle(rawValue: rawValue)
    }

    public var underlineStyle: NSUnderlineStyle? {
        guard let rawValue = attrs[NSUnderlineStyleAttributeName] as? Int else {
            return nil
        }
        return NSUnderlineStyle(rawValue: rawValue)
    }

    public var strokeWidth: Float? {
        return attrs[NSStrokeWidthAttributeName] as? Float
    }

    public var strokeColor: UIColor? {
        return attrs[NSStrokeColorAttributeName] as? UIColor
    }

    public var shadow: NSShadow? {
        return attrs[NSShadowAttributeName] as? NSShadow
    }

    public var isLetterPressed: Bool {
        guard let textEffect = attrs[NSTextEffectAttributeName] as? String else {
            return false
        }
        return textEffect == NSTextEffectLetterpressStyle
    }
}
