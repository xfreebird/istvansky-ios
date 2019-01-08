# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Istvan Sky' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_modular_headers!

  # Pods for Istvan Sky
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'Firebase/Performance'
  pod 'Firebase/Core'
  pod 'Firebase/Storage'
  pod 'Firebase/Messaging'
  pod 'Firebase/InAppMessagingDisplay'
  pod 'SnapKit', '~> 4.2.0'
  pod 'Marshal', :modular_headers => true
  pod 'Swinject'
  pod 'SDWebImage', '~> 4.0'
  pod 'YoutubeKit'
  pod 'XCDYouTubeKit', '~> 2.7'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
        end
    end
end
