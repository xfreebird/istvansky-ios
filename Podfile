# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Istvan Sky' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_modular_headers!

  # Pods for Istvan Sky
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Performance'
  pod 'Firebase/Core'
  pod 'Firebase/Storage'
  pod 'Firebase/Messaging'
  pod 'Firebase/InAppMessaging'
  pod 'SnapKit', '~> 5.0'
  pod 'Marshal', :modular_headers => true
  pod 'Swinject'
  pod 'SDWebImage', '~> 5.6'
  pod 'XCDYouTubeKit', '~> 2.12'
  pod 'YoutubeKit', :git => 'https://github.com/xfreebird/YoutubeKit.git', :branch => 'master'
end

target 'NSE' do
  pod 'Firebase/Messaging'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
        end
    end
end
