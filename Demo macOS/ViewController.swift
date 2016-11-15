//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Cocoa
import RichString

class ViewController: NSViewController {

    @IBOutlet weak var label1: NSTextField!
    @IBOutlet weak var label2: NSTextField!

    override func viewWillAppear() {
        super.viewWillAppear()
        if let text1 = "This is some text"
            .fontSize(17)?.color(.blue).strikeThrough(style: .styleDouble) {
            label1.attributedStringValue = text1
        }

        let text2 = "This is some text".verticalGlyphForm(1)
        label2.attributedStringValue = text2
    }
}
