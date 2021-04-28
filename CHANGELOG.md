2.2.1
=====
Fixes issue #3: `entireString` method for unicode characters. Thanks @rapidfireworks!


2.2.0
=====
Converted to Swift 4.2.


2.1.0
=====
Removed use of deprecated `String.characters` property, gets rid of compiler warning.


2.0.0
=====
Converted to Swift 4.


1.2.4
=====
Changed the documentation URL to point to github pages, because CocoaDocs is not generating the docs
properly. So documentation is now at https://svdo.github.io/swift-RichString.


1.2.3
=====
Fixed an issue where release builds of projects using RichString would
give 'undefined symbol' linker errors.


1.2.2
=====
Still no changes, still trying to get CocoaDocs generation to work, this time by explicitly adding
`.swift-version` file.


1.2.1
=====
No changes; just making another version hoping that CocoaDocs generation will now work correctly.
See also: https://github.com/svdo/swift-RichString/issues/1.


1.2.0
=====
Added support for tvOS and watchOS.


1.1.0
=====
When querying attributes, it is no longer required that they were applied to the entire
range of the attributed string. Instead, the attribute value *at the end of the string* is used.


1.0.0
=====
First version of the RichString framework.
