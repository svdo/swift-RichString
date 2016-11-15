//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation

// MARK: - Simple attributes
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
        }
        else {
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

    @available(iOS, unavailable)
    public func verticalGlyphForm(_ form: Int) -> NSAttributedString {
        return addingAttribute(NSVerticalGlyphFormAttributeName, value: form)
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
extension NSAttributedString {
    var attrs: [String: Any] {
        var range: NSRange = NSRange()
        let attrs          = self.attributes(at: 0, effectiveRange: &range)
        assert(range.location == 0)
        assert(range.length == self.length,
               "StringAttributes is intended for strings that have attributes on the whole range")
        return attrs
    }

    public var color: Color? {
        return attrs[NSForegroundColorAttributeName] as? Color
    }

    public var backgroundColor: Color? {
        return attrs[NSBackgroundColorAttributeName] as? Color
    }

    public var fontSize: CGFloat? {
        return (attrs[NSFontAttributeName] as? Font)?.pointSize
    }

    public var isBold: Bool {
        guard let font = attrs[NSFontAttributeName] as? Font else {
            return false
        }
        return font.fontDescriptor.hasBoldTrait
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

    public var strikeThroughColor: Color? {
        return attrs[NSStrikethroughColorAttributeName] as? Color
    }

    public var underlineStyle: NSUnderlineStyle? {
        guard let rawValue = attrs[NSUnderlineStyleAttributeName] as? Int else {
            return nil
        }
        return NSUnderlineStyle(rawValue: rawValue)
    }

    public var underlineColor: Color? {
        return attrs[NSUnderlineColorAttributeName] as? Color
    }

    public var strokeWidth: Float? {
        return attrs[NSStrokeWidthAttributeName] as? Float
    }

    public var strokeColor: Color? {
        return attrs[NSStrokeColorAttributeName] as? Color
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

    public var link: NSURL? {
        if let string = attrs[NSLinkAttributeName] as? String {
            return NSURL(string: string)
        } else {
            return attrs[NSLinkAttributeName] as? NSURL
        }
    }

    public var attachment: NSTextAttachment? {
        return attrs[NSAttachmentAttributeName] as? NSTextAttachment
    }

    public var baselineOffset: Float? {
        return attrs[NSBaselineOffsetAttributeName] as? Float
    }

    public var obliqueness: Float? {
        return attrs[NSObliquenessAttributeName] as? Float
    }

    public var expansion: Float? {
        return attrs[NSExpansionAttributeName] as? Float
    }

    @available(iOS, unavailable)
    public var verticalGlyphForm: Int? {
        return attrs[NSVerticalGlyphFormAttributeName] as? Int
    }
}
