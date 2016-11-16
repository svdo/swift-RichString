abstract_target 'RichString' do
  use_frameworks!

  target 'RichString iOS' do
    platform :ios, '10.0'
  end
  target 'RichString macOS' do
    platform :osx, '10.12'
  end

  abstract_target 'RichStringTests' do
    inherit! :search_paths
    pod 'Quick', '~> 0.10'
    pod 'Nimble', '~> 5.1'

    target 'RichStringTests iOS' do
      platform :ios, '10.0'
    end
    target 'RichStringTests macOS' do
      platform :osx, '10.12'
    end
  end

end
