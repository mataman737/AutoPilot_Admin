# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AutoPilot_Admin' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end

  # Pods for AutoPilot_Admin

pod 'lottie-ios'
pod 'WXImageCompress'
pod 'Disk'
pod 'AWSS3'
pod 'FlagPhoneNumber'
pod 'StreamChatUI'
pod 'PhotoCircleCrop'
pod 'WXImageCompress'
pod 'Kingfisher'
pod 'AgoraRtcEngine_iOS'
pod 'PWSwitch'
pod 'NWWebSocket'
pod 'FSCalendar'
pod 'DateTimePicker'
pod 'EFQRCode', '~> 6.2.0'
pod 'YPImagePicker', :git => 'https://github.com/LawrenceNorman/YPImagePicker.git'
end
