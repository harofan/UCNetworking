Pod::Spec.new do |s|
  s.name         = "UCNetworking"
  s.version      = "1.0"
  s.summary      = "一个去model化的AFNetworking的封装"
  s.homepage     = "https://github.com/RPGLiker/UCNetworking"
  s.license      = "MIT"
  s.author       = { "RPGLiker" => "fanyang_32012@outlook.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/RPGLiker/UCNetworking.git", :tag => "#{s.version}" }
  s.source_files  = "UCNetworking/UCNetworking/**/*.{h,m}"
  s.requires_arc = true
  # s.exclude_files = "Classes/Exclude"
  s.dependency 'AFNetworking'
  s.dependency 'YYCache'

end