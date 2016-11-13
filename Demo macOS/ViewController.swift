//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import Cocoa
import RichString

class ViewController: NSViewController {

    @IBOutlet weak var label1: NSTextField!

    override func viewWillAppear() {
        super.viewWillAppear()
        if let text1 = "This is some text"
            .fontSize(17)?.color(.blue).strikeThrough(style: .styleDouble) {
            label1.attributedStringValue = text1
        }
    }
}
