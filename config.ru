# This file is used by Rack-based servers to start the application.

if ENV['RAILS_ENV'] == 'production'
  ENV['GEM_PATH'] = "/home/apple28/.gems"
  Gem.clear_paths
end

require ::File.expand_path('../config/environment',  __FILE__)
run Apple::Application
