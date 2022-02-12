# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'tmdb' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for tmdb
  pod 'Alamofire', '~> 5.2.0'
  pod 'PromiseKit', '~> 6.8'
  pod 'Kingfisher', '~> 4.0'
  
  target 'tmdbTests' do
    inherit! :search_paths
    # Pods for testing
  end
end

# --- PRE INSTALL ACTIONS ------
pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
end

# --- POST INSTALL ACTIONS ------
post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
    end
end
