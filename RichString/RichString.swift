//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation
import UIKit

public protocol RichString {

    func font(_ font: UIFont) -> NSAttributedString

    /**
     * Applies the given font size to the attributed string. If no font was set on the
     * attributed string yet, UIFont.systemFont will be assumed.
     * - parameter size: The desired point size of the attributed string.
     * - returns: Attributed string with the given font size attribute.
     */
    func fontSize(_ size: CGFloat) -> NSAttributedString

    func bold() -> NSAttributedString

    func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString

    func color(_ color: UIColor) -> NSAttributedString
    func backgroundColor(_ color: UIColor) -> NSAttributedString

    func ligature(_ ligature: Int) -> NSAttributedString
    func kern(_ kern: Float) -> NSAttributedString

    func strikeThrough(style: NSUnderlineStyle) -> NSAttributedString
    func underline(style: NSUnderlineStyle) -> NSAttributedString

    func stroke(width: Float, color: UIColor) -> NSAttributedString

    func shadow(_ shadow: NSShadow) -> NSAttributedString
}
