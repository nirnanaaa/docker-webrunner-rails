#!/usr/bin/env ruby
#
require 'yaml'

if File.exist?("/data/config/additional_packages.yml")
  packages = YAML.load_file("/data/config/additional_packages.yml")
  inst = packages["install"].join(" ")
  `apt-get update -yqq`
  `apt-get install #{inst} -yqq`
end
