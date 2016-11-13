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

    public func paragraphStyle(configuration: (NSMutableParagraphStyle) -> Void)
            -> NSAttributedString {
        return rich.paragraphStyle(configuration: configuration)
    }

    public func ligature(_ ligature: Int) -> NSAttributedString {
        return rich.ligature(ligature)
    }

    public func kern(_ kern: Float) -> NSAttributedString {
        return rich.kern(kern)
    }

    public func strikeThrough(style: NSUnderlineStyle) -> NSAttributedString {
        return rich.strikeThrough(style: style)
    }

    public func strikeThrough(color: UIColor) -> NSAttributedString {
        return rich.strikeThrough(color: color)
    }

    public func underline(style: NSUnderlineStyle) -> NSAttributedString {
        return rich.underline(style: style)
    }

    public func underline(color: UIColor) -> NSAttributedString {
        return rich.underline(color: color)
    }

    public func stroke(width: Float, color: UIColor) -> NSAttributedString {
        return rich.stroke(width: width, color: color)
    }

    public func shadow(_ shadow: NSShadow) -> NSAttributedString {
        return rich.shadow(shadow)
    }

    public func letterPressed() -> NSAttributedString {
        return rich.letterPressed()
    }

    public func link(url: NSURL) -> NSAttributedString {
        return rich.link(url: url)
    }

    public func link(string: String) -> NSAttributedString {
        return rich.link(string: string)
    }

    public func attachment(configure: (NSTextAttachment) -> Void)
            -> NSAttributedString {
        return rich.attachment(configure: configure)
    }

    public func baselineOffset(_ offset: Float) -> NSAttributedString {
        return rich.baselineOffset(offset)
    }

    public func obliqueness(_ obliqueness: Float) -> NSAttributedString {
        return rich.obliqueness(obliqueness)
    }

    public func expansion(_ expansion: Float) -> NSAttributedString {
        return rich.expansion(expansion)
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
