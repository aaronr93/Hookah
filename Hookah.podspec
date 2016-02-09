Pod::Spec.new do |s|
  s.name         = "Hookah"
  s.version      = "1.0.0"
  s.summary      = "Hookah is a functional library for Swift. It’s inspired by Lo-Dash project."
  s.homepage     = "https://github.com/HookahSwift/Hookah"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "khoi" => "khoi.geeky@gmail.com" }
  s.source       = { :git => "https://github.com/HookahSwift/Hookah.git", :tag => "#{s.version}" }
  s.source_files  = 'Source/*.{swift,h,m}'
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc = true
end