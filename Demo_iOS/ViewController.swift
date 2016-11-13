//  Copyright © 2016 Stefan van den Oord. All rights reserved.

import UIKit
import RichString

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        let text1 = "This is some text".fontSize(17).color(.blue).strikeThrough(style: .styleDouble)
        let text2 = "This is some text".fontSize(17).color(.blue).bold().obliqueness(0.5)
        let text3 = text1 + text2.color(.red)
        let text4 = loremIpsum.paragraphStyle {
            $0.lineHeightMultiple = 1.2
            $0.firstLineHeadIndent = 20
        }.fontSize(15)

        label1.attributedText = text1
        label2.attributedText = text2
        label3.attributedText = text3
        label4.attributedText = text4
    }
}

let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
    "Vivamus malesuada neque eget velit finibus, ac fringilla leo imperdiet. " +
    "Maecenas ullamcorper sem eros, vitae feugiat arcu ultricies eu. Morbi sit " +
    "amet diam dictum, auctor est quis, malesuada ipsum. Mauris nisl velit, " +
    "tempus nec faucibus vitae, varius sit amet ligula. Nullam non lorem sit " +
    "amet quam convallis finibus a vel ligula. Donec suscipit enim imperdiet " +
    "ligula auctor, hendrerit mollis urna posuere. Nulla at quam efficitur, " +
    "rutrum dolor vel, tincidunt nunc. Mauris augue orci, ultrices a sodales " +
    "euismod, porta ut urna. Maecenas ullamcorper neque non felis elementum " +
    "aliquet. Nam sit amet tempus dui."
