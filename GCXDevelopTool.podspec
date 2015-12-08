

Pod::Spec.new do |s|

  s.name         = "GCXDevelopTool"

  s.version      = "0.0.1"

  s.summary      = "A short description of GCXDevelopTool:Easy To Develop IOS"

  s.description  = <<-DESC
                            Easy To Develop IOS
                            DESC
  s.homepage     = "https://github.com/gaocaixin/GCXDevelopTool"

  s.license      = "MIT"

  s.author             = { "高才新" => "767374741@qq.com" }

  s.source       = { :git => "https://github.com/gaocaixin/GCXDevelopTool", :tag =>  s.version }

  s.platform     = :ios, '4.3'

  s.requires_arc = true

  s.source_files  = 'GCXDevelopTool/*'

  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
end
