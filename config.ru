# This file is used by Rack-based servers to start the application.

if ENV['RAILS_ENV'] == 'production'  # don't bother on dev
  ENV['GEM_PATH'] = '/home/USERNAME/.gems' + ':/usr/lib/ruby/gems/1.8'
end

require ::File.expand_path('../config/environment',  __FILE__)
run Apple::Application
