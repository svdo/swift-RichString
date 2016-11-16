//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation

/**
 * The RichString protocol defines the interface of this framework.
 *
 * - Note: All attributes are always applied on the *entire range* of the attributed string.
 *         This means that you normally create attributed strings for the text parts that have
 *         the desired attributes, and then concatenate them (using operator `+(_:_:)` for example).
 */
public protocol RichString {

    /**
     * Apply the given font. The type `Font` is a type alias of `UIFont` on iOS,
     * and of `NSFont` on macOS.
     *
     * - Param font: The font that the attributed string should have.
     * - Returns: A new attributed string that has the given font attribute.
     */
    func font(_ font: Font) -> NSAttributedString

    #if os(iOS)
        /**
         * Applies the given font size. If no font was set on the
         * attributed string yet, `Font.systemFont` will be assumed.
         *
         * - Parameter size: The desired point size of the attributed string.
         * - Returns: A new attributed string that has the given font size attribute.
         */
        func fontSize(_ size: CGFloat) -> NSAttributedString

        /**
         * Makes the font bold. The attributed string must already have a font applied
         * at this point, because otherwise we don't know what to make bold.
         *
         * - Precondition: a font must already have been configured, for example using
         *                 `font(_:)` or `fontSize(_:)`.
         *
         * - Returns: A new attributed string that has the bold version of its font applied.
         */
        func bold() -> NSAttributedString
    #elseif os(macOS)
        /**
         * Applies the given font size. If no font was set on the
         * attributed string yet, `Font.systemFont` will be assumed.
         *
         * - Parameter size: The desired point size of the attributed string.
         * - Returns: A new attributed string that has the given font size attribute.
         */
        func fontSize(_ size: CGFloat) -> NSAttributedString?

        /**
         * Makes the font bold. The attributed string must already have a font applied
         * at this point, because otherwise we don't know what to make bold.
         *
         * - Precondition: a font must already have been configured, for example using
         *                 `font(_:)` or `fontSize(_:)`.
         *
         * - Returns: A new attributed string that has the bold version of its font applied.
         */
        func bold() -> NSAttributedString?
    #endif

    /**
     * Applies the given paragraph style.
     *
     * - Parameter paragraphStyle: The paragraph style that is applied.
     * - Returns: A new attributed string that has the paragraph style applied.
     */
    func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString

    /**
     * Applies a paragraph style, configuring it with the given closure. If the attributed
     * string already had a paragraph style attribute, the `configure` closure is called
     * on that paragraph style; otherwise a new `NSMutableParagraphStyle` is used.
     *
     * - Parameter configure: The closure that you can use to configure the paragraph style.
     * - Returns: A new attributed string that has the configured paragraph style applied.
     */
    func paragraphStyle(configure: (NSMutableParagraphStyle) -> Void)
            -> NSAttributedString

    /**
     * Applies the given (foreground) color.
     *
     * - Parameter color: The foreground color that is applied.
     * - Returns: A new attributed string that has the given foreground color.
     */
    func color(_ color: Color) -> NSAttributedString

    /**
     * Applies the given background color.
     *
     * - Parameter color: the background color that is applied
     * - Returns: a new attributed string that has the given background color.
     */
    func backgroundColor(_ color: Color) -> NSAttributedString

    func ligature(_ ligature: Int) -> NSAttributedString
    func kern(_ kern: Float) -> NSAttributedString

    func strikeThrough(style: NSUnderlineStyle) -> NSAttributedString
    func strikeThrough(color: Color) -> NSAttributedString
    func strikeThrough(color: Color, style: NSUnderlineStyle) -> NSAttributedString
    func underline(style: NSUnderlineStyle) -> NSAttributedString
    func underline(color: Color) -> NSAttributedString
    func underline(color: Color, style: NSUnderlineStyle) -> NSAttributedString

    func stroke(width: Float, color: Color) -> NSAttributedString

    func shadow(_ shadow: NSShadow) -> NSAttributedString
    func shadow(configure: (NSShadow) -> Void) -> NSAttributedString

    func letterPressed() -> NSAttributedString

    func link(url: NSURL) -> NSAttributedString
    func link(string: String) -> NSAttributedString

    func attachment(configure: (NSTextAttachment) -> Void)
            -> NSAttributedString

    func baselineOffset(_ offset: Float) -> NSAttributedString

    func obliqueness(_ obliqueness: Float) -> NSAttributedString

    func expansion(_ expansion: Float) -> NSAttributedString

    func verticalGlyphForm(_ form: Int) -> NSAttributedString
}
