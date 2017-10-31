# RichString
*The easiest way to work with attributed strings in Swift*

![Swift Version 4](https://img.shields.io/badge/Swift-v4-yellow.svg)
[![Percentage Documented Badge](https://img.shields.io/cocoapods/metrics/doc-percent/RichString.svg)](http://cocoadocs.org/docsets/RichString)
[![CocoaPods Version Badge](https://img.shields.io/cocoapods/v/RichString.svg)](https://cocoapods.org/pods/RichString)
![Supported Platforms Badge](https://img.shields.io/cocoapods/p/RichString.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/svdo/swift-RichString/blob/master/LICENSE)

iOS ![iOS build status](https://www.bitrise.io/app/be72b9e151cd07b0.svg?token=uNzPxW7-U72W8caT90H4-Q)
| tvOS ![tvOS build status](https://www.bitrise.io/app/3cb0152b1c621436.svg?token=enlInfw6qhO19_0agJgvKQ)
| watchOS ![watchOS build status](https://www.bitrise.io/app/a86fb3ebe514205f.svg?token=sxbknzRtbt8oxi92Jqpang)
| macOS ![macOS build status](https://www.bitrise.io/app/ac72d77b90795a96.svg?token=I2foSCluNAsaxKyujIvFMQ)


## Introduction
This Swift framework was built to simplify working with `NSAttributedString`. It does
so without adding additional types; it just extends the existing types that you already have,
ensuring that it is fully interoperable with any other method of using `NSAttributedString`.

The core assumption this framework makes, is that you
set up your attributed strings by first configuring
all components appropriately, and then concatenating
them.

It allows you to do things like this:

```swift
let title = "This is a title".fontSize(17).color(.blue)
let text = "This is some text".paragraphStyle {
    $0.firstLineHeadIndent = 20
}
let content = title + text
```

## Overview
This framework provides the following primitives.
There are unit tests; have a look at them for more
examples.

### Operator `+` For Concatenating Attributed Strings
Given two strings, you can append one to the other
using the `+` operator:

```swift
let s1 = NSAttributedString()
let s2 = NSAttributedString()
let concatenated = s1 + s2
```

### `RichString` protocol for `String`, `NSString` and `NSAttributedString`

#### font(_:)
Apply the given font. The type `Font` is a type
alias of `UIFont` on iOS, and of `NSFont` on macOS.

```swift
let attributedString = "text".font(.systemFont(ofSize: 12))
```
#### fontSize(_:)
Applies the given font size. If no font was set on
the attributed string yet, `Font.systemFont` will be
assumed.

Note: unlike on iOS, on macOS this returns an
*optional* attributed string instead.

```swift
let attributedString = "text".fontSize(12)
```

#### paragraphStyle(configure:)
Applies a paragraph style, configuring it with the
given closure. If the attributed string already had
a paragraph style attribute, the `configure` closure
is called on that paragraph style; otherwise a new
`NSMutableParagraphStyle` is used.
```swift
let attributedString = "Hello World".paragraphStyle {
    $0.firstLineHeadIndent = 10
}
```

#### paragraphStyle(_:)
Applies the given paragraph style.

```swift
let paragraphStyle = NSMutableParagraphStyle()
paragraphStyle.firstLineHeadIndent = 10
let attributedString = "text".paragraphStyle(paragraphStyle)
```

#### color(_:)
Applies the given (foreground) color.

```swift
let attributedString = "text".color(.blue)
```

#### backgroundColor(_:)
Applies the given background color.

```swift
let attributedString = "text".backgroundColor(.yellow)
```

#### ligature(_:)
Configures whether or not to use ligatures. Default
is that they are used.

```swift
let attributedString = "text".ligature(false)
```

#### kern(_:)
Configures the amount with which to modify the
default kerning. The default `0` means that no
kerning change is applied.

```swift
let attributedString = "text".kern(0.1)
```

#### strikeThrough(style:)
Configures the strike through style.

Please note that depending on OS and version not all
styles may actually work.

```swift
let attributedString = "text".strikeThrough(style: .styleSingle)
```

#### strikeThrough(color:)
Configures the strike through color.
Only setting the color has no effect, the style must
be configured as well.

```swift
let attributedString = "text".strikeThrough(color: .red)
```

#### strikeThrough(color:, style:)
Configures both the strike through color and style.
Please note that depending on OS and version not all
styles may actually work.

```swift
let attributedString = "text".strikeThrough(color: .red, style: .styleDouble)
```

#### underline(style:)
Configures the underline style.
Please note that depending on OS and version not all
styles may actually work.

```swift
let attributedString = "text".underline(style: .styleSingle)
```

#### underline(color:)
Configures the underline color.
Only setting the color has no effect, the style must
be configured as well.

```swift
let attributedString = "text".underline(color: .blue)
```

#### underline(color:, style:)
Configures both the underline color and style.
Please note that depending on OS and version not all
styles may actually work.

```swift
let attributedString = "text".underline(color: .blue, style: .styleSingle)
```

#### stroke(width:, color:)
Configures the stroke.

```swift
let attributedString = "text".stroke(width: 2, color: .green)
```

#### shadow(configure:)
Configures the shadow using a closure that receives
an `NSShadow` instance. Not available on watchOS.

```swift
let result = "Hello World".shadow {
    $0.shadowOffset = CGSize(width: 3, height: 3)
    $0.shadowBlurRadius = 2
    $0.shadowColor = Color.gray
}
```

#### shadow(_:)
Configures the shadow by setting an `NSShadow`
instance. Not available on watchOS.

```swift
let shadow = NSShadow()
shadow.shadowColor = .green
shadow.shadowBlurRadius = 2
shadow.shadowOffset = 3
let attributedString = "text".shadow(shadow)
```

#### letterPressed()
Adds the "letter pressed" text effect.

```swift
let attributedString = "text".letterPressed()
```

#### link(url:)
Creates hyperlink to the given URL with the receiver
as text.

```swift
let url = URL(string: "https://example.com")
let attributedString = "text".link(url: url)
```

#### link(string:)
Creates hyperlink to the given URL with the receiver
as text.

```swift
let urlString = "https://example.com"
let attributedString = "text".link(string: urlString)
```

#### attachment(configure:)
Creates a new `NSTextAttachment` and passes it to the
`configure` closure. Not available on watchOS.

```swift
let attributedString = NSAttributedString().attachment {
    $0.image = UIImage(...)
    $0.bounds = CGRect(...)
}
```

#### baselineOffset(_:)
Configures the baseline offset.

```swift
let attributedString = "text".baselineOffset(-0.5)
```

#### obliqueness(_:)
Configures the skew to be applied to glyphs.

```swift
let attributedString = "text".obliqueness(1.5)
```

#### expansion(_:)
Configures the expansion to be applied to glyphs.

```swift
let attributedString = "text".expansion(2)
```

### `NSAttributedString` Extension for Getting Attribute Values

All of the above methods have corresponding getters
to retrieve the attribute values from the attributed
string. The all return an optional; if the attribute
is not configured on the attributed string, `nil`
will be returned.

The getters are:
- `attachment: NSTextAttachment?` (not available on watchOS)
- `backgroundColor: Color?`
- `baselineOffset: Float?`
- `color: Color?`
- `expansion: Float?`
- `fontSize: CGFloat?`
- `isLetterPressed: Bool?`
- `kern: Float?`
- `ligature: Bool?`
- `link: NSURL?`
- `obliqueness: Float?`
- `paragraphStyle: NSParagraphStyle?`
- `shadow: NSShadow?` (not available on watchOS)
- `strikeThroughColor: Color?`
- `strikeThroughStyle: NSUnderlineStyle?`
- `strokeColor: Color?`
- `strokeWidth: Float?`
- `underlineColor: Color?`
- `underlineStyle: NSUnderlineStyle?`

## Usage
You can use the library any way you like, but two
easy ways are Carthage and CocoaPods. For CocoaPods,
put `pod RichString` in your `Podfile`.

## Alternative Frameworks
I found a couple other frameworks that have the same goal as this one: simplifying using
`NSAttributedString`. I like mine better, mostly because it has a simpler API that doesn't
use any additional types. But I'll let you choose for yourself.

[TextAttributes](https://github.com/delba/TextAttributes) is similar to this framework, but it
introduces a new type that you have to set up the attributes, instead of working directly on
the strings themselves. It doesn't feature the cool closure-based way of setting up
`shadow { ... }` and `paragraphStyle { ... }` that this framework has. And it doesn't provide
the super-convenient `+` operator that this framework does. Finally, I didn't test this framework
on tvOS and watchOS. I'm rather confident that those will work as well, but you'll have to try.
Pull requests are wellcome of course.

[TextAttributesUtil](https://github.com/muukii/TextAttributesUtil) also introduces a new type
for setting up the attributes. Also, it's API forces you to have more levels of nesting in your
source code. It only supports iOS, not macOS.
