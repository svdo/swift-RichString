//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Foundation
import Quick
import Nimble
import RichString

class RichStringSpec: QuickSpec {
    override func spec() {
        it("can append attributed strings using operator +") {
            let str1 = NSAttributedString(string: "hello")
            let str2 = NSAttributedString(string: " world")
            expect((str1+str2).string) == "hello world"
        }
    }
}
