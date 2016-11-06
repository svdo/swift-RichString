//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import UIKit
import RichString

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        let text1 = "This is some text".fontSize(17).color(.blue)
        let text2 = "This is some text".fontSize(17).color(.blue).bold()
        let text3 = text1 + text2.color(.red)

        label1.attributedText = text1
        label2.attributedText = text2
        label3.attributedText = text3
    }
}
