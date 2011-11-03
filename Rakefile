require "rubygems"
require "bundler"
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

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end