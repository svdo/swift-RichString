// Copyright (c) 2016 Stefan van den Oord. All rights reserved.

import Foundation
import Quick
import Nimble
import RichString

// swiftlint:disable force_cast
class RichSpec: QuickConfiguration {
    // swiftlint:disable function_body_length
    override class func configure(_ configuration: Configuration!) {
        sharedExamples("rich string") { (sharedExampleContext: @escaping SharedExampleContext) in
            var richString: RichString {
                return sharedExampleContext()["string"] as! RichString
            }

            it("can add a color") {
                let result = richString.color(.red)
                expect(result.color) == .red
            }

            it("can add a background color") {
                let result = richString.backgroundColor(.green)
                expect(result.backgroundColor) == .green
            }

            it("can add a font size") {
                let result = richString.fontSize(42)
                #if os(iOS)
                    let actualFontSize = result.fontSize
                #elseif os(macOS)
                    let actualFontSize = result!.fontSize
                #endif
                expect(actualFontSize) ≈ 42.0
            }

            it("can make it bold") {
                let result = richString.font(.systemFont(ofSize: 10)).bold()
                #if os(iOS)
                    let actualResult = result.isBold
                #elseif os(macOS)
                    let actualResult = result!.isBold
                #endif
                expect(actualResult).to(beTrue())
            }

            it("can add a paragraph style") {
                let style = NSParagraphStyle()
                let result = richString.paragraphStyle(style)
                expect(result.paragraphStyle) == style
            }

            it("can configure new paragraph style") {
                let result = richString.paragraphStyle {
                    $0.firstLineHeadIndent = 10
                }
                expect(result.paragraphStyle).toNot(beNil())
                if let style = result.paragraphStyle {
                    expect(style.firstLineHeadIndent) ≈ 10
                }
            }

            it("can add to configuration of existing paragraph style") {
                let result = richString.paragraphStyle {
                    $0.firstLineHeadIndent = 10
                }.paragraphStyle {
                    $0.lineHeightMultiple = 1.4
                }
                expect(result.paragraphStyle).toNot(beNil())
                if let style = result.paragraphStyle {
                    expect(style.firstLineHeadIndent) ≈ 10
                    expect(style.lineHeightMultiple) ≈ 1.4
                }
            }

            it("can add a ligature") {
                let result = richString.ligature(2)
                expect(result.ligature) == 2
            }

            it("can add a kern") {
                let result = richString.kern(2)
                expect(result.kern) == 2
            }

            it("can add strike through style") {
                let result = richString.strikeThrough(style: .styleDouble)
                expect(result.strikeThroughStyle) == .styleDouble
            }

            it("can add strike through color") {
                let result = richString.strikeThrough(color: .cyan)
                expect(result.strikeThroughColor) == .cyan
            }

            it("can add underline style") {
                let result = richString.underline(style: .patternDashDot)
                expect(result.underlineStyle) == .patternDashDot
            }

            it("can add underline color") {
                let result = richString.underline(color: .purple)
                expect(result.underlineColor) == .purple
            }

            it("can add stroke") {
                let result = richString.stroke(width: 4, color: .green)
                expect(result.strokeWidth) == 4
                expect(result.strokeColor) == .green
            }

            it("can add shadow") {
                let shadow = NSShadow()
                shadow.shadowOffset = CGSize(width: 3, height: 3)
                shadow.shadowBlurRadius = 2
                shadow.shadowColor = Color.gray
                let result = richString.shadow(shadow)
                expect(result.shadow) == shadow
            }

            it("can add letter press effect") {
                let result = richString.letterPressed()
                expect(result.isLetterPressed) == true
            }

            it("can add a URL link") {
                let url = NSURL(string: "https://localhost")!
                let result = richString.link(url: url)
                expect(result.link) == url
            }

            it("can add a string link") {
                let urlString = "https://localhost"
                let result = richString.link(string: urlString)
                expect(result.link) == NSURL(string: urlString)!
            }

            it("can configure new text attachment") {
                let rect = CGRect(x: 1, y: 2, width: 3, height: 4)
                let result = richString.attachment {
                    $0.bounds = rect
                }
                expect(result.attachment).toNot(beNil())
                if let attachment = result.attachment {
                    expect(attachment.bounds) == rect
                }
            }

            it("can set baseline offset") {
                let result = richString.baselineOffset(3.14)
                expect(result.baselineOffset) ≈ 3.14
            }

            it("can set obliqueness") {
                let result = richString.obliqueness(1)
                expect(result.obliqueness) ≈ 1
            }

            it("can set expansion") {
                let result = richString.expansion(1.23)
                expect(result.expansion) ≈ 1.23
            }

            #if os(macOS)
                it("can set vertical glyph format") {
                    let result = richString.verticalGlyphForm(1)
                    expect(result.verticalGlyphForm) == 1
                }
            #endif
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
