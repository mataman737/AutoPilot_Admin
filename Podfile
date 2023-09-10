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
    
    #iOS 17 support, remove once CocoaPods 1.13 releases
    installer.aggregate_targets.each do |target|
        target.xcconfigs.each do |variant, xcconfig|
          xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
          IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
        end
      end
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
            xcconfig_path = config.base_configuration_reference.real_path
            IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
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

# Add the Firebase pod for Google Analytics
pod 'FirebaseAnalytics'

# For Analytics without IDFA collection capability, use this pod instead
# pod ‘Firebase/AnalyticsWithoutAdIdSupport’

# Add the pods for any other Firebase products you want to use in your app
# For example, to use Firebase Authentication and Cloud Firestore
pod 'FirebaseAuth'
pod 'FirebaseFirestore'
pod 'FirebaseDynamicLinks'

end
