//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation
import Quick
import Nimble
import RichString

class RichStringSpec: QuickSpec {
    override func spec() {
        it("can append attributed strings using operator +") {
            let s1 = NSAttributedString(string: "hello")
            let s2 = NSAttributedString(string: " world")
            expect((s1+s2).string) == "hello world"
        }
    }
}
