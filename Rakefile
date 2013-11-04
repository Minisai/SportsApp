require File.expand_path('../config/application', __FILE__)
unless Rails.env.production?
  require 'ci/reporter/rake/rspec'
end

SportsApp::Application.load_tasks

