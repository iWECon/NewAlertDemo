#
#  Be sure to run `pod spec lint IWAlert.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "IWAlert"
  s.version      = "1.0.1"
  s.summary      = "A new ALERT, like iOS10, 一个仿iOS10中Safari的提示框第三方框架"
  s.description  = <<-DESC
                    仿iOS10的一个对话框/提示框
                    确定取消按钮置于右下角
                   DESC
  s.homepage     = "https://github.com/iWECon/NewAlertDemo"
  s.license      = "MIT"
  s.author       = { "iWECon" => "i.1214@yahoo.com" }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/iWECon/NewAlertDemo.git", :tag => "1.0.1" }
  s.source_files = 'NewAlertDemo/', 'NewAlertDemo/IWNewAlert/*.{h,m}'
  s.requires_arc = true
end
