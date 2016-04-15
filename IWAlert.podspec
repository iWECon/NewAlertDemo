#
#  Be sure to run `pod spec lint IWAlert.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "IWAlert"
  s.version      = "1.0.0"
  s.summary      = "A new ALERT, like iOS10"
  s.description  = <<-DESC
                      A new ALERT, like iOS10
                   DESC
  s.homepage     = "https://github.com/iWECon/NewAlertDemo"
  s.license      = "MIT (example)"
  s.author       = { "iWECon" => "i.1214@yahoo.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/iWECon/NewAlertDemo.git", :tag => "1.0.0" }
  s.source_files  = "IWNewAlert/", "/*.{h，m}"
  s.requires_arc = true
end
