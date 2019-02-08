//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import WatchKit
import Foundation
import RichString

class InterfaceController: WKInterfaceController {

    @IBOutlet var label1: WKInterfaceLabel!
    @IBOutlet var label2: WKInterfaceLabel!
    @IBOutlet var label3: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        let text1 = "This is some text".fontSize(17).color(.blue).strikeThrough(style: .double)
        let text2 = "This is some text".fontSize(17).color(.red).obliqueness(0.5).expansion(0.5)
        let text3 = text1 + text2.color(.red)

        label1.setAttributedText(text1)
        label2.setAttributedText(text2)
        label3.setAttributedText(text3)
    }
}
