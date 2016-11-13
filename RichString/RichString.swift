//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation

public protocol RichString {

    func font(_ font: Font) -> NSAttributedString

    #if os(iOS)
        /**
         * Applies the given font size to the attributed string. If no font was set on the
         * attributed string yet, UIFont.systemFont will be assumed.
         * - parameter size: The desired point size of the attributed string.
         * - returns: Attributed string with the given font size attribute.
         */
        func fontSize(_ size: CGFloat) -> NSAttributedString

        func bold() -> NSAttributedString
    #elseif os(macOS)
        /**
         * Applies the given font size to the attributed string. If no font was set on the
         * attributed string yet, UIFont.systemFont will be assumed.
         * - parameter size: The desired point size of the attributed string.
         * - returns: Attributed string with the given font size attribute.
         */
        func fontSize(_ size: CGFloat) -> NSAttributedString?

        func bold() -> NSAttributedString?
    #endif

    func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString

    func color(_ color: Color) -> NSAttributedString
    func backgroundColor(_ color: Color) -> NSAttributedString

    func ligature(_ ligature: Int) -> NSAttributedString
    func kern(_ kern: Float) -> NSAttributedString

    func strikeThrough(style: NSUnderlineStyle) -> NSAttributedString
    func strikeThrough(color: Color) -> NSAttributedString
    func underline(style: NSUnderlineStyle) -> NSAttributedString
    func underline(color: Color) -> NSAttributedString

    func stroke(width: Float, color: Color) -> NSAttributedString

    func shadow(_ shadow: NSShadow) -> NSAttributedString

    func letterPressed() -> NSAttributedString

    func link(url: NSURL) -> NSAttributedString
    func link(string: String) -> NSAttributedString

    func paragraphStyle(configuration: (NSMutableParagraphStyle) -> Void)
            -> NSAttributedString

    func attachment(configure: (NSTextAttachment) -> Void)
            -> NSAttributedString

    func baselineOffset(_ offset: Float) -> NSAttributedString

    func obliqueness(_ obliqueness: Float) -> NSAttributedString

    func expansion(_ expansion: Float) -> NSAttributedString
}
