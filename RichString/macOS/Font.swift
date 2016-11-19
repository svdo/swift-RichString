//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import AppKit

public typealias Font = NSFont

let fontBoldTrait = NSFontSymbolicTraits(NSFontBoldTrait)

extension NSFontDescriptor {
    var hasBoldTrait: Bool {
        return (symbolicTraits & fontBoldTrait) == fontBoldTrait
    }
}

// MARK: - Font attributes
extension NSAttributedString {
    public func fontSize(_ size: CGFloat) -> NSAttributedString? {
        let attrs = self.attributes(at: 0, effectiveRange: nil)
        let fontAttrs = attrs.filter {
            $0.0 == NSFontAttributeName
        }

        let font: Font
        if fontAttrs.count > 0, let f = fontAttrs[0].1 as? Font {
            font = f
        } else {
            font = Font.systemFont(ofSize: 0)
        }
        let sizedDescriptor = font.fontDescriptor.withSize(size)
        guard let sizedFont = Font(descriptor: sizedDescriptor, size: 0) else {
            return nil
        }
        return self.font(sizedFont)
    }
}

extension NonAttributedString {
    public func fontSize(_ size: CGFloat) -> NSAttributedString? {
        return rich.fontSize(size)
    }
}
