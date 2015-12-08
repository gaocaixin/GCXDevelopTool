

Pod::Spec.new do |s|

  s.name         = "GCXDevelopTool"

  s.version      = "1.0.2"

  s.summary      = "A short description of GCXDevelopTool:Easy To Develop IOS"

  s.description  = <<-DESC
                            更便利开发 IOS.集成各类方法.
                            DESC
  s.homepage     = "https://github.com/gaocaixin/GCXDevelopTool"

  s.license      = 'MIT'

  s.author             = { "高才新" => "767374741@qq.com" }

  s.source       = { :git => "https://github.com/gaocaixin/GCXDevelopTool.git", :tag =>  s.version }

  s.platform     = :ios, '6.0'

  s.requires_arc = true

  s.source_files  = 'GCXDevelopTool/*'

  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
end
