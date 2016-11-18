# RichText
*The easiest way to work with attributed strings in Swift*

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![license](https://img.shields.io/github/license/mashape/apistatus.svg)]()

## Introduction
This Swift framework was built to simplify working with `NSAttributedString`. It does
so without adding additional types; it just extends the existing types that you already have,
ensuring that it is fully interoperable with any other method of using `NSAttributedString`.

It allows you to do things like this:

    let text1 = "This is some text".fontSize(17).color(.blue)
    let text2 = "This is some text".fontSize(17).color(.blue).bold()
    let text3 = text1 + text2.color(.red)

This is work in progress. Still, feedback is already welcome if you have any. Just create an issue.

## Alternative Frameworks

- https://github.com/delba/TextAttributes
- https://github.com/muukii/TextAttributesUtil
