// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Foundation
import UIKit
import Quick
import Nimble
import RichString

// swiftlint:disable force_cast
class RichSpec: QuickConfiguration {
    override class func configure(_ configuration: Configuration!) {
        sharedExamples("rich string") { (sharedExampleContext: @escaping SharedExampleContext) in
            var richString: RichString {
                return sharedExampleContext()["string"] as! RichString
            }

            it("can add a color") {
                let result = richString.color(UIColor.red)
                expect(result.color) == UIColor.red
            }

            it("can add a background color") {
                let result = richString.backgroundColor(UIColor.green)
                expect(result.backgroundColor) == UIColor.green
            }

            it("can add a font size") {
                let result = richString.fontSize(42)
                expect(result.fontSize) ≈ 42.0
            }

            it("can add a paragraph style") {
                let style = NSParagraphStyle()
                let result = richString.paragraphStyle(style)
                expect(result.paragraphStyle) == style
            }
        }
    }
}

class NSAttributedStringRichSpec: QuickSpec {
    override func spec() {
        context("when used on attributed string") {
            itBehavesLike("rich string") { ["string": NSAttributedString(string: "test")] }
        }

        context("when used on string") {
            itBehavesLike("rich string") { ["string": "test"] }
        }

        context("when used on NSString") {
            itBehavesLike("rich string") { ["string": "test" as NSString] }
        }
    }
}
