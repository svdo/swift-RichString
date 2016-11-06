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
            expect(s.color) == UIColor.red
        }

        it("can add a font size") {
            let s = NSAttributedString(string: "test").fontSize(42)
            expect(s.fontSize) ≈ 42.0
        }
    }
}
