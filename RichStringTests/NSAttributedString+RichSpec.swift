// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Foundation
import UIKit
import Quick
import Nimble
import RichString

class NSAttributedStringRichSpec: QuickSpec {
    override func spec() {
        context("when used on attributed string") {
            var s: NSAttributedString!
            beforeEach {
                s = NSAttributedString(string: "test")
            }

            it("can add a color") {
                let result = s.color(UIColor.red)
                expect(result.color) == UIColor.red
            }

            it("can add a font size") {
                let result = s.fontSize(42)
                expect(result.fontSize) ≈ 42.0
            }
        }

        context("when used on string") {
            var s: String!
            beforeEach {
                s = "test"
            }

            it("can add a color") {
                let result = s.color(UIColor.red)
                expect(result.color) == UIColor.red
            }

            it("can add a font size") {
                let result = s.fontSize(42)
                expect(result.fontSize) ≈ 42.0
            }
        }
    }
}
