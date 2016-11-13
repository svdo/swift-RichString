//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import UIKit

public typealias Font = UIFont

let fontBoldTrait = UIFontDescriptorSymbolicTraits.traitBold

extension UIFontDescriptor {
    var hasBoldTrait: Bool {
        return symbolicTraits.contains(.traitBold)
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

        let font = fontAttrs[0].1 as? Font
        let boldDescriptor = font?.fontDescriptor.withSymbolicTraits(fontBoldTrait)

        precondition(boldDescriptor != nil, "failed to create bold font descriptor")

        let boldFont = Font(descriptor: boldDescriptor!, size: 0)
        return self.font(boldFont)
    }

    public func fontSize(_ size: CGFloat) -> NSAttributedString {
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
        let sizedFont = Font(descriptor: sizedDescriptor, size: 0)
        return self.font(sizedFont)
    }
}

extension NonAttributedString {
    public func bold() -> NSAttributedString {
        return rich.bold()
    }

    public func fontSize(_ size: CGFloat) -> NSAttributedString {
        return rich.fontSize(size)
    }
}
