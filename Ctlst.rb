#!/usr/bin/env ruby
# frozen_string_literal: true

begin
  require_relative "templates/#{ARGV[0]}"
  Template.main(*ARGV.drop(1))
rescue LoadError
  print "No such template '#{ARGV[0]}'\n"
end
