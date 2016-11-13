abstract_target 'RichString' do
  use_frameworks!

  target 'RichString iOS'
  target 'RichString macOS'

  abstract_target 'RichStringTests' do
    inherit! :search_paths
    pod 'Quick', '~> 0.10'
    pod 'Nimble', '~> 5.1'

    target 'RichStringTests iOS'
    target 'RichStringTests macOS'
  end

end
