# RichText
*The easiest way to work with attributed strings in Swift*

## Introduction
This Swift framework was built to simplify working with `NSAttributedString`. It allows you to do things like this:

    let text1 = "This is some text".fontSize(17).color(.blue)
    let text2 = "This is some text".fontSize(17).color(.blue).bold
    let text3 = text1 + text2.color(.red)

This is work in progress. Still, feedback is already welcome if you have any. Just create an issue.
