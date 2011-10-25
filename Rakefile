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

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << File.dirname(__FILE__)
  t.pattern = 'test/*.rb'
end