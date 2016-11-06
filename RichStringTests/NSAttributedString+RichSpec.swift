// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Foundation
import UIKit
import Quick
import Nimble
import RichString

class NSAttributedStringRichSpec: QuickSpec {
    override func spec() {
        it("can add a color") {
            let s = NSAttributedString(string: "test").color(UIColor.red)
            expect(s.attrs.color) == UIColor.red
        }

        it("can add a font size") {
            let s = NSAttributedString(string: "test").fontSize(42)
            expect(s.attrs.fontSize) ≈ 42.0
        }
    }
}

extension NSAttributedString {
    var attrs: StringAttributes {
        return StringAttributes(string: self)
    }
}

struct StringAttributes {
    var attrs: [String:Any]

    init(string: NSAttributedString) {
        var range: NSRange = NSRange()
        attrs = string.attributes(at: 0, effectiveRange: &range)
        assert(range.location == 0)
        assert(range.length == string.length,
               "StringAttributes is intended for strings that have attributes on the whole range")
    }

    var color: UIColor? {
        return attrs[NSForegroundColorAttributeName] as? UIColor
    }

    var fontSize: CGFloat? {
        return (attrs[NSFontAttributeName] as? UIFont)?.pointSize
    }
}
