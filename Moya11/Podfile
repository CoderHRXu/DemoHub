
platform :ios, '11.0'

use_frameworks!

	def net_pod
        pod 'Moya'
        pod 'Moya/RxSwift'
        pod 'RxSwift' 
        pod 'PromiseKit'
        pod 'PromiseKit/Alamofire'
        pod 'HandyJSON' #A Json Serialization & Deserialization Library for Swift
        pod 'Evil'
    end

target 'Moya11Learn' do 

	net_pod

end 

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'HandyJSON'
            target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
    end
end