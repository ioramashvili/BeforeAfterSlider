Pod::Spec.new do |s|
  s.name             = 'BeforeAfterSlider'
  s.version          = '0.1.1'
  s.summary          = 'Slide before and after image'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
 
  s.description      = <<-DESC
Before and after image slider
                       DESC
 
  s.homepage         = 'https://github.com/ioramashvili/BeforeAfterSlider'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shota ioramashvili' => 'shotaioramashvili@gmail.com' }
  s.source           = { :git => 'https://github.com/ioramashvili/BeforeAfterSlider.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'BeforeAfterSlider/BeforeAfterView.swift'
 
end