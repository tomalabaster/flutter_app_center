#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_app_center'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter plugin for using Microsoft App Center.'
  s.description      = <<-DESC
A Flutter plugin for using Microsoft App Center.
                       DESC
  s.homepage         = 'https://github.com/tomalabaster/flutter_app_center'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Tom Alabaster' => 'tomalabasteruk@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'AppCenter'
  s.static_framework = true

  s.ios.deployment_target = '10.0'
end

