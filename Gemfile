source 'https://rubygems.org'

gem 'cocoapods'
gem 'fastlane'
gem 'generamba', :git => 'https://github.com/strongself/Generamba', :branch => 'develop'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval(File.read(plugins_path), binding) if File.exist?(plugins_path)
