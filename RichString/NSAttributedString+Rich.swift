//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation

// MARK: - Simple attributes

/**
 * Extension to add all RichString functionality to `NSAttributedString`.
 */
extension NSAttributedString: RichString {
    public func color(_ color: Color) -> NSAttributedString {
        return addingAttribute(NSForegroundColorAttributeName, value: color)
    }

    public func backgroundColor(_ color: Color) -> NSAttributedString {
        return addingAttribute(NSBackgroundColorAttributeName, value: color)
    }

    public func font(_ font: Font) -> NSAttributedString {
        return addingAttribute(NSFontAttributeName, value: font)
    }

    public func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        return addingAttribute(NSParagraphStyleAttributeName, value: paragraphStyle)
    }

    public func paragraphStyle(configure: (NSMutableParagraphStyle) -> Void)
            -> NSAttributedString {
        let style: NSMutableParagraphStyle
        if let existingStyle = self.paragraphStyle as? NSMutableParagraphStyle {
            style = existingStyle
        } else if let existingStyle = self.paragraphStyle,
                  let mutableCopy = existingStyle.mutableCopy() as? NSMutableParagraphStyle {
            style = mutableCopy
        } else {
            style = NSMutableParagraphStyle()
        }
        configure(style)
        return addingAttribute(NSParagraphStyleAttributeName, value: style)
    }

    public func ligature(_ ligature: Bool) -> NSAttributedString {
        return addingAttribute(NSLigatureAttributeName, value: ligature ? 1 : 0)
    }

    public func kern(_ kern: Float) -> NSAttributedString {
        return addingAttribute(NSKernAttributeName, value: kern)
    }

    public func strikeThrough(style: NSUnderlineStyle) -> NSAttributedString {
        return addingAttribute(NSStrikethroughStyleAttributeName,
                               value: style.rawValue)
    }

    public func strikeThrough(color: Color) -> NSAttributedString {
        return addingAttribute(NSStrikethroughColorAttributeName, value: color)
    }

    public func strikeThrough(color: Color, style: NSUnderlineStyle) -> NSAttributedString {
        return strikeThrough(color: color).strikeThrough(style: style)
    }

    public func underline(style: NSUnderlineStyle) -> NSAttributedString {
        return addingAttribute(NSUnderlineStyleAttributeName,
                               value: style.rawValue)
    }

    public func underline(color: Color) -> NSAttributedString {
        return addingAttribute(NSUnderlineColorAttributeName, value: color)
    }

    public func underline(color: Color, style: NSUnderlineStyle)
            -> NSAttributedString {
        return underline(color: color).underline(style: style)
    }

    public func stroke(width: Float, color: Color) -> NSAttributedString {
        return addingAttribute(NSStrokeColorAttributeName,
                               value: color)
            .addingAttribute(NSStrokeWidthAttributeName,
                             value: width)
    }

    public func shadow(_ shadow: NSShadow) -> NSAttributedString {
        return addingAttribute(NSShadowAttributeName, value: shadow)
    }

    public func shadow(configure: (NSShadow) -> Void) -> NSAttributedString {
        let shadow: NSShadow
        if let s = self.shadow {
            shadow = s
        } else {
            shadow = NSShadow()
        }
        configure(shadow)
        return self.shadow(shadow)
    }

    public func letterPressed() -> NSAttributedString {
        return addingAttribute(NSTextEffectAttributeName,
                               value: NSTextEffectLetterpressStyle)
    }

    public func link(url: NSURL) -> NSAttributedString {
        return addingAttribute(NSLinkAttributeName, value: url)
    }

    public func link(string: String) -> NSAttributedString {
        return addingAttribute(NSLinkAttributeName, value: string)
    }

    public func attachment(configure: (NSTextAttachment) -> Void)
            -> NSAttributedString {
        let attachment = NSTextAttachment()
        configure(attachment)
        return addingAttribute(NSAttachmentAttributeName, value: attachment)
    }

    public func baselineOffset(_ offset: Float) -> NSAttributedString {
        return addingAttribute(NSBaselineOffsetAttributeName, value: offset)
    }

    public func obliqueness(_ obliqueness: Float) -> NSAttributedString {
        return addingAttribute(NSObliquenessAttributeName, value: obliqueness)
    }

    public func expansion(_ expansion: Float) -> NSAttributedString {
        return addingAttribute(NSExpansionAttributeName, value: expansion)
    }
}

// MARK: - Private helpers
extension NSAttributedString {
    func addingAttribute(_ name: String, value: Any)
            -> NSAttributedString {
        let m = makeMutable()
        let r = entireString()
        m.addAttribute(name, value: value, range: r)
        return NSAttributedString(attributedString: m)
    }

    func makeMutable() -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }

    func entireString() -> NSRange {
        return NSRange(location: 0, length: self.string.characters.count)
    }
}

// MARK: - Attribute getters

/**
 * Extension to add attribute getters to `NSAttributedString`.
 */
extension NSAttributedString {
    var attrs: [String: Any] {
        var range: NSRange = NSRange()
        let attrs          = self.attributes(at: 0, effectiveRange: &range)
        assert(range.location == 0)
        assert(range.length == self.length,
               "StringAttributes is intended for strings that have attributes on the whole range")
        return attrs
    }

    /**
     * - Returns: The configured color, if any.
     * - See: `RichString.color(_:)`
     */
    public var color: Color? {
        return attrs[NSForegroundColorAttributeName] as? Color
    }

    /**
     * - Returns: The configured background color, if any.
     * - See: `RichString.backgroundColor(_:)`
     */
    public var backgroundColor: Color? {
        return attrs[NSBackgroundColorAttributeName] as? Color
    }

    /**
     * - Returns: The configured font size, if any.
     * - See: `RichString.fontSize(_:)`
     */
    public var fontSize: CGFloat? {
        return (attrs[NSFontAttributeName] as? Font)?.pointSize
    }

    /**
     * - Returns: Whether or not the configured font (if any) is bold.
     * - See: `RichString.bold()`
     */
    public var isBold: Bool {
        guard let font = attrs[NSFontAttributeName] as? Font else {
            return false
        }
        return font.fontDescriptor.hasBoldTrait
    }

    /**
     * - Returns: The configured paragraph style.
     * - See: `RichString.paragraphStyle(_:)`
     * - See: `RichString.paragraphStyle(configure:)`
     */
    public var paragraphStyle: NSParagraphStyle? {
        return attrs[NSParagraphStyleAttributeName] as? NSParagraphStyle
    }

    /**
     * - Returns: Whether or not ligatures are enabled (if configured).
     * - See: `RichString.ligature(_:)`
     */
    public var ligature: Bool? {
        guard let ligatureNumber = attrs[NSLigatureAttributeName] as? Int else {
            return nil
        }
        return ligatureNumber == 1
    }

    /**
     * - Returns: The configured kerning, if any.
     * - See: `RichString.kern(_:)`
     */
    public var kern: Float? {
        return attrs[NSKernAttributeName] as? Float
    }

    /**
     * - Returns: The configured strike through style, if any.
     * - See: `RichString.strikeThrough(style:)`
     * - See: `RichString.strikeThrough(color:,style:)`
     */
    public var strikeThroughStyle: NSUnderlineStyle? {
        guard let rawValue = attrs[NSStrikethroughStyleAttributeName] as? Int else {
            return nil
        }
        return NSUnderlineStyle(rawValue: rawValue)
    }

    /**
     * - Returns: The configured strike through color, if any.
     * - See: `RichString.strikeThrough(color:)`
     * - See: `RichString.strikeThrough(color:,style:)`
     */
    public var strikeThroughColor: Color? {
        return attrs[NSStrikethroughColorAttributeName] as? Color
    }

    /**
     * - Returns: The configured underline style, if any.
     * - See: `RichString.underline(style:)`
     * - See: `RichString.underline(color:,style:)`
     */
    public var underlineStyle: NSUnderlineStyle? {
        guard let rawValue = attrs[NSUnderlineStyleAttributeName] as? Int else {
            return nil
        }
        return NSUnderlineStyle(rawValue: rawValue)
    }

    /**
     * - Returns: The configured underline color, if any.
     * - See: `RichString.underline(color:)`
     * - See: `RichString.underline(color:,style:)`
     */
    public var underlineColor: Color? {
        return attrs[NSUnderlineColorAttributeName] as? Color
    }

    /**
     * - Returns: The configured stroke width, if any.
     * - See: `RichString.stoke(width:,color:)`
     */
    public var strokeWidth: Float? {
        return attrs[NSStrokeWidthAttributeName] as? Float
    }

    /**
     * - Returns: The configured stroke color, if any.
     * - See: `RichString.stroke(width:,color:)`
     */
    public var strokeColor: Color? {
        return attrs[NSStrokeColorAttributeName] as? Color
    }

    /**
     * - Returns: The configured shadow, if any.
     * - See: `RichString.shadow(_:)`
     * - See: `RichString.shadow(configure:)`
     */
    public var shadow: NSShadow? {
        return attrs[NSShadowAttributeName] as? NSShadow
    }

    /**
     * - Returns: Whether or not the letter pressed text effect is configured.
     * - See: `RichString.letterPressed()`
     */
    public var isLetterPressed: Bool? {
        guard let textEffect = attrs[NSTextEffectAttributeName] as? String else {
            return nil
        }
        return textEffect == NSTextEffectLetterpressStyle
    }

    /**
     * - Returns: The configured URL, if any.
     * - See: `RichString.link(string:)`
     * - See: `RichString.link(url:)`
     */
    public var link: NSURL? {
        if let string = attrs[NSLinkAttributeName] as? String {
            return NSURL(string: string)
        } else {
            return attrs[NSLinkAttributeName] as? NSURL
        }
    }

    /**
     * - Returns: The configured attachment, if any.
     * - See: `RichString.attachment(configure:)`
     */
    public var attachment: NSTextAttachment? {
        return attrs[NSAttachmentAttributeName] as? NSTextAttachment
    }

    /**
     * - Returns: The configured baseline offset, if any.
     * - See: `RichString.baselineOffset(_:)`
     */
    public var baselineOffset: Float? {
        return attrs[NSBaselineOffsetAttributeName] as? Float
    }

    /**
     * - Returns: The configured obliqueness (skew), if any.
     * - See: `RichString.obliqueness(_:)`
     */
    public var obliqueness: Float? {
        return attrs[NSObliquenessAttributeName] as? Float
    }

    /**
     * - Returns: The configured expansion, if any.
     * - See: `RichString.expansion(_:)`
     */
    public var expansion: Float? {
        return attrs[NSExpansionAttributeName] as? Float
    }
}
