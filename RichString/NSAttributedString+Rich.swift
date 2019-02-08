//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation

#if SWIFT_PACKAGE || os(macOS)
    import AppKit
#else
    import UIKit
#endif

// MARK: - Simple attributes

/**
 * Extension to add all RichString functionality to `NSAttributedString`.
 */
extension NSAttributedString: RichString {
    public func color(_ color: Color) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.foregroundColor.rawValue, value: color)
    }

    public func backgroundColor(_ color: Color) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.backgroundColor.rawValue, value: color)
    }

    public func font(_ font: Font) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.font.rawValue, value: font)
    }

    public func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.paragraphStyle.rawValue, value: paragraphStyle)
    }

    public func paragraphStyle(configure: (NSMutableParagraphStyle) -> Void)
            -> NSAttributedString {
        let style: NSMutableParagraphStyle
        if let existingStyle = self.paragraphStyle,
           let mutableCopy = existingStyle.mutableCopy() as? NSMutableParagraphStyle {
            style = mutableCopy
        } else {
            style = NSMutableParagraphStyle()
        }
        configure(style)
        return addingAttribute(NSAttributedString.Key.paragraphStyle.rawValue, value: style)
    }

    public func ligature(_ ligature: Bool) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.ligature.rawValue, value: ligature ? 1 : 0)
    }

    public func kern(_ kern: Float) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.kern.rawValue, value: kern)
    }

    public func strikeThrough(style: NSUnderlineStyle) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.strikethroughStyle.rawValue,
                               value: style.rawValue)
    }

    public func strikeThrough(color: Color) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.strikethroughColor.rawValue, value: color)
    }

    public func strikeThrough(color: Color, style: NSUnderlineStyle) -> NSAttributedString {
        return strikeThrough(color: color).strikeThrough(style: style)
    }

    public func underline(style: NSUnderlineStyle) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.underlineStyle.rawValue,
                               value: style.rawValue)
    }

    public func underline(color: Color) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.underlineColor.rawValue, value: color)
    }

    public func underline(color: Color, style: NSUnderlineStyle)
            -> NSAttributedString {
        return underline(color: color).underline(style: style)
    }

    public func stroke(width: Float, color: Color) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.strokeColor.rawValue,
                               value: color)
            .addingAttribute(NSAttributedString.Key.strokeWidth.rawValue,
                             value: width)
    }

    #if !os(watchOS)

        public func shadow(_ shadow: NSShadow) -> NSAttributedString {
            return addingAttribute(NSAttributedString.Key.shadow.rawValue, value: shadow)
        }

        public func shadow(configure: (NSShadow) -> Void) -> NSAttributedString {
            let shadow: NSShadow
            if let myShadow = self.shadow {
                shadow = myShadow
            } else {
                shadow = NSShadow()
            }
            configure(shadow)
            return self.shadow(shadow)
        }

        public func attachment(configure: (NSTextAttachment) -> Void)
            -> NSAttributedString {
                let attachment = NSTextAttachment()
                configure(attachment)
                return addingAttribute(NSAttributedString.Key.attachment.rawValue, value: attachment)
        }

    #endif

    public func letterPressed() -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.textEffect.rawValue,
                               value: NSAttributedString.TextEffectStyle.letterpressStyle)
    }

    public func link(url: NSURL) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.link.rawValue, value: url)
    }

    public func link(string: String) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.link.rawValue, value: string)
    }

    public func baselineOffset(_ offset: Float) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.baselineOffset.rawValue, value: offset)
    }

    public func obliqueness(_ obliqueness: Float) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.obliqueness.rawValue, value: obliqueness)
    }

    public func expansion(_ expansion: Float) -> NSAttributedString {
        return addingAttribute(NSAttributedString.Key.expansion.rawValue, value: expansion)
    }
}

// MARK: - Private helpers
extension NSAttributedString {
    func addingAttribute(_ name: String, value: Any)
            -> NSAttributedString {
        let mutableMe = makeMutable()
        let range = entireString()
        mutableMe.addAttribute(NSAttributedString.Key(rawValue: name), value: value, range: range)
        return NSAttributedString(attributedString: mutableMe)
    }

    func makeMutable() -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }

    func entireString() -> NSRange {
        return NSRange(location: 0, length: self.string.count)
    }
}

// MARK: - Attribute getters

/**
 * Extension to add attribute getters to `NSAttributedString`.
 */
extension NSAttributedString {
    var attrs: [NSAttributedString.Key: Any] {
        guard self.length > 0 else {
            return [:]
        }

        var range: NSRange = NSRange()
        let attrs = self.attributes(at: self.length - 1, effectiveRange: &range)
        return attrs
    }

    /**
     * - Returns: The configured color, if any.
     * - See: `RichString.color(_:)`
     */
    public var color: Color? {
        return attrs[NSAttributedString.Key.foregroundColor] as? Color
    }

    /**
     * - Returns: The configured background color, if any.
     * - See: `RichString.backgroundColor(_:)`
     */
    public var backgroundColor: Color? {
        return attrs[NSAttributedString.Key.backgroundColor] as? Color
    }

    /**
     * - Returns: The configured font size, if any.
     * - See: `RichString.fontSize(_:)`
     */
    public var fontSize: CGFloat? {
        return (attrs[NSAttributedString.Key.font] as? Font)?.pointSize
    }

    /**
     * - Returns: The configured paragraph style.
     * - See: `RichString.paragraphStyle(_:)`
     * - See: `RichString.paragraphStyle(configure:)`
     */
    public var paragraphStyle: NSParagraphStyle? {
        return attrs[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle
    }

    /**
     * - Returns: Whether or not ligatures are enabled (if configured).
     * - See: `RichString.ligature(_:)`
     */
    public var ligature: Bool? {
        guard let ligatureNumber = attrs[NSAttributedString.Key.ligature] as? Int else {
            return nil
        }
        return ligatureNumber == 1
    }

    /**
     * - Returns: The configured kerning, if any.
     * - See: `RichString.kern(_:)`
     */
    public var kern: Float? {
        return attrs[NSAttributedString.Key.kern] as? Float
    }

    /**
     * - Returns: The configured strike through style, if any.
     * - See: `RichString.strikeThrough(style:)`
     * - See: `RichString.strikeThrough(color:,style:)`
     */
    public var strikeThroughStyle: NSUnderlineStyle? {
        guard let rawValue = attrs[NSAttributedString.Key.strikethroughStyle] as? Int else {
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
        return attrs[NSAttributedString.Key.strikethroughColor] as? Color
    }

    /**
     * - Returns: The configured underline style, if any.
     * - See: `RichString.underline(style:)`
     * - See: `RichString.underline(color:,style:)`
     */
    public var underlineStyle: NSUnderlineStyle? {
        guard let rawValue = attrs[NSAttributedString.Key.underlineStyle] as? Int else {
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
        return attrs[NSAttributedString.Key.underlineColor] as? Color
    }

    /**
     * - Returns: The configured stroke width, if any.
     * - See: `RichString.stoke(width:,color:)`
     */
    public var strokeWidth: Float? {
        return attrs[NSAttributedString.Key.strokeWidth] as? Float
    }

    /**
     * - Returns: The configured stroke color, if any.
     * - See: `RichString.stroke(width:,color:)`
     */
    public var strokeColor: Color? {
        return attrs[NSAttributedString.Key.strokeColor] as? Color
    }

    #if !os(watchOS)

        /**
         * - Returns: The configured shadow, if any.
         * - See: `RichString.shadow(_:)`
         * - See: `RichString.shadow(configure:)`
         */
        public var shadow: NSShadow? {
            return attrs[NSAttributedString.Key.shadow] as? NSShadow
        }

        /**
         * - Returns: The configured attachment, if any.
         * - See: `RichString.attachment(configure:)`
         */
        public var attachment: NSTextAttachment? {
            return attrs[NSAttributedString.Key.attachment] as? NSTextAttachment
        }

    #endif

    /**
     * - Returns: Whether or not the letter pressed text effect is configured.
     * - See: `RichString.letterPressed()`
     */
    public var isLetterPressed: Bool? {
        guard let textEffect = attrs[NSAttributedString.Key.textEffect] as? NSAttributedString.TextEffectStyle else {
            return nil
        }
        return textEffect == NSAttributedString.TextEffectStyle.letterpressStyle
    }

    /**
     * - Returns: The configured URL, if any.
     * - See: `RichString.link(string:)`
     * - See: `RichString.link(url:)`
     */
    public var link: NSURL? {
        if let string = attrs[NSAttributedString.Key.link] as? String {
            return NSURL(string: string)
        } else {
            return attrs[NSAttributedString.Key.link] as? NSURL
        }
    }

    /**
     * - Returns: The configured baseline offset, if any.
     * - See: `RichString.baselineOffset(_:)`
     */
    public var baselineOffset: Float? {
        return attrs[NSAttributedString.Key.baselineOffset] as? Float
    }

    /**
     * - Returns: The configured obliqueness (skew), if any.
     * - See: `RichString.obliqueness(_:)`
     */
    public var obliqueness: Float? {
        return attrs[NSAttributedString.Key.obliqueness] as? Float
    }

    /**
     * - Returns: The configured expansion, if any.
     * - See: `RichString.expansion(_:)`
     */
    public var expansion: Float? {
        return attrs[NSAttributedString.Key.expansion] as? Float
    }
}
