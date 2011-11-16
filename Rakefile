require "rubygems"
require "bundler"
require 'yaml'
Bundler.setup

$:.unshift('.').uniq!
ENV['RACK_ENV'] ||= "development"

namespace :log do
  desc "clear log files"
  task :clear do
    Dir["log/*.log"].each do |log_file|
      f = File.open(log_file, "w")
      f.close
    end
  end
end

namespace :db do
  desc "Load seed data"
  task :seed do
    load("db/seeds.rb")
  end
end

namespace :heroku do
  desc 'Deploy to heroku & set required config values from config/config.yml'
  task :deploy do
    config = YAML.load_file('config/config.yml')
    config_key_value_pairs = ["heroku=true"]
    config.each do |key, value|
      config_key_value_pairs << "#{key}=\"#{value}\"" unless key == "database"
    end
    system("heroku config:add #{config_key_value_pairs.join(" ")}")
    system("git push heroku master")
  end
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end