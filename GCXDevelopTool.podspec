

Pod::Spec.new do |s|

  s.name         = "GCXDevelopTool"

  s.version      = "1.1.8"

  s.summary      = "Easy To Develop IOS."

  s.homepage     = "https://github.com/gaocaixin/GCXDevelopTool"

  s.license      = 'MIT'

  s.author             = { "高才新" => "767374741@qq.com" }

  s.source       = { :git => "https://github.com/gaocaixin/GCXDevelopTool.git", :tag =>  s.version.to_s }


  s.ios.deployment_target = '7.0'

  s.requires_arc = true

s.source_files  = 'GCXDevelopTool/*.{h,m}'

  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
end
