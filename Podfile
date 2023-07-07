# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DD_Motors' do
  
   use_frameworks!
   
  pod 'SVPinView', '~> 1.0'
  
  pod 'IQKeyboardManagerSwift'
  pod 'SlideMenuControllerSwift'
  pod 'Alamofire', '~> 4.0'
  
  pod 'Toast-Swift', '~> 5.0.1'
  pod "GSMessages"
  pod 'EasyTipView', '~> 2.0.4'
  pod 'SRScratchView'

  pod 'lottie-ios'
  pod "ImageSlideshow/Alamofire"
  pod 'CashfreePG', '~> 2.0.3'
  pod 'Kingfisher', '~> 7.0'

  pod 'FirebaseAnalytics'
  
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'Crashlytics', '~> 3.14.0'
  pod 'Firebase/Crashlytics'
  
  pod 'Firebase/Analytics'
  pod 'SDWebImage'
pod 'Firebase/Messaging'
  pod 'Firebase/Core'

end
post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 11.0
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
            end
         end
     end
  end
