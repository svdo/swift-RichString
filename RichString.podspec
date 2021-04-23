Pod::Spec.new do |s|
  s.name                      = "RichString"
  s.version                   = "2.2.1"
  s.summary                   = "The easiest way to work with attributed strings in Swift."
  s.description               = <<-DESC
                                This Swift framework was built to simplify working with `NSAttributedString`. It does
                                so without adding additional types; it just extends the existing types that you already have,
                                ensuring that it is fully interoperable with any other method of using `NSAttributedString`.
                                DESC

  s.homepage                  = "https://github.com/svdo/swift-RichString"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = "Stefan van den Oord"
  s.documentation_url         = "https://svdo.github.io/swift-RichString/"

  s.ios.deployment_target     = "10.0"
  # Just to be on the safe side; I haven't tested this with older versions of macOS:
  s.osx.deployment_target     = "10.11"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target    = "10.0"

  s.source                    = { :git => "https://github.com/svdo/swift-RichString.git",
                                  :tag => "#{s.version}" }
  s.ios.source_files          = "RichString/*.swift", "RichString/iOS/*.swift"
  s.osx.source_files          = "RichString/*.swift", "RichString/macOS/*.swift"
  s.watchos.source_files      = "RichString/*.swift", "RichString/watchos/*.swift"
  s.tvos.source_files         = "RichString/*.swift", "RichString/tvos/*.swift"
end
