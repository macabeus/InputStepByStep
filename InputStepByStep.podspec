Pod::Spec.new do |s|
  s.name         = "InputStepByStep"
  s.version      = "0.0.2-beta"
  s.summary      = "A simple input view for tvOS, for testing purposes"
  s.homepage     = "https://github.com/brunomacabeusbr/InputStepByStep"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Bruno Macabeus" => "bruno.macabeus@gmail.com" }

  s.tvos.deployment_target = "10.0"

  s.source       = { :git => "https://github.com/brunomacabeusbr/InputStepByStep.git", :tag => s.version }
  s.source_files = "InputStepByStep/InputStepByStep/*.swift", "InputStepByStep/InputStepByStep/*.xib"

  s.dependency 'Cartography', '~> 1.1'
end
