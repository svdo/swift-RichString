//  Copyright © 2016 Stefan van den Oord. All rights reserved.

// MARK: - iOS
#if os(iOS) || os(watchOS) || os(tvOS)

    import UIKit

    public typealias Font = UIFont

    let fontBoldTrait = UIFontDescriptor.SymbolicTraits.traitBold

    extension UIFontDescriptor {
        var hasBoldTrait: Bool {
            return symbolicTraits.contains(.traitBold)
        }
    }

    extension NSAttributedString {
        public func fontSize(_ size: CGFloat) -> NSAttributedString {
            let attrs = self.attributes(at: 0, effectiveRange: nil)
            let fontAttrs = attrs.filter {
                $0.0 == NSAttributedString.Key.font
            }

            let font: Font
            if fontAttrs.count > 0, let fst = fontAttrs.first?.1 as? Font {
                font = fst
            } else {
                font = Font.systemFont(ofSize: size)
            }
            let sizedDescriptor = font.fontDescriptor.withSize(size)
            let sizedFont = Font(descriptor: sizedDescriptor, size: size)
            return self.font(sizedFont)
        }
    }

    extension NonAttributedString {
        public func fontSize(_ size: CGFloat) -> NSAttributedString {
            return rich.fontSize(size)
        }
    }

// MARK: - macOS
#elseif os(macOS)

    import AppKit

    public typealias Font = NSFont

    let fontBoldTrait = NSFontSymbolicTraits(NSFontBoldTrait)

    extension NSFontDescriptor {
        var hasBoldTrait: Bool {
            return (symbolicTraits.rawValue & fontBoldTrait) == fontBoldTrait
        }
    }

    extension NSAttributedString {
        public func fontSize(_ size: CGFloat) -> NSAttributedString? {
            let attrs = self.attributes(at: 0, effectiveRange: nil)
            let fontAttrs = attrs.filter {
                $0.0 == NSAttributedString.Key.font
            }

            let font: Font
            if fontAttrs.count > 0, let fst = fontAttrs.first?.1 as? Font {
                font = fst
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

#endif
