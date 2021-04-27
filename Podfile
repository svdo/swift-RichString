abstract_target 'RichString' do
  use_frameworks!

  target 'RichString iOS' do
    platform :ios, '10.0'
  end
  target 'RichString macOS' do
    platform :osx, '10.12'
  end
  target 'RichString watchOS' do
    platform :watchos, '2.0'
  end
  target 'RichString tvOS' do
    platform :tvos, '10.0'
  end

  abstract_target 'RichStringTests' do
    pod 'Quick', '~> 3.0', :inhibit_warnings => true
    pod 'Nimble', '~> 9.0'

    target 'RichStringTests iOS' do
      platform :ios, '10.0'
    end
    target 'RichStringTests macOS' do
      platform :osx, '10.12'
    end
    target 'RichStringTests tvOS' do
      platform :tvos, '10.0'
    end
  end

end
