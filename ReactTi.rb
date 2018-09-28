#!/usr/bin/env ruby
# frozen_string_literal: true
require 'ERB'
# Requirements:
# npm install -g create-react-app

def get_all_copy_files
  Dir.glob(__dir__+"/template/*", File::FNM_DOTMATCH).reject do |path|
    path =~ /\.$|\.\.$|\.erb$/
  end
end

def parse_all_templates
  erbs = Dir.glob(__dir__+"/template/*", File::FNM_DOTMATCH).select do |path|
    path =~ /\.erb$/
  end
  erbs.each do |erb|
    erb_contents = File.read(erb)
    open(erb.sub(/^.*\//,'').sub(/\.erb$/, ''), 'w') { |f|
      f.print ERB.new(erb_contents).result(binding)
    }
  end
end

if ARGV.length < 1
  print "Requires a project name\n"
  exit
end

#We need to make sure there's no such folder so we don't overwrite or filebomb something important
#Note name can't be a capital letter
@project_name = ARGV[0]

%x[create-react-app #{@project_name}]
Dir.chdir "./#{@project_name}" do
  %x[git init]
  %x[npm install storybook]
  %x[getstorybook]

  get_all_copy_files.each do |path|
    `cp #{path} .`
  end

  parse_all_templates
end
