#!/usr/bin/env ruby
# frozen_string_literal: true
require 'fileutils'
require 'ERB'

def get_all_copy_dirs
  Dir.glob(__dir__+"/new/**/*", File::FNM_DOTMATCH).select do |path|
    File.directory?(path)
  end
end

def get_all_copy_files
  Dir.glob(__dir__+"/new/**/*", File::FNM_DOTMATCH).reject do |path|
    path =~ /^\.$|^\.\.$|\.erb$/ || File.directory?(path)
  end
end

def parse_all_templates
  erbs = Dir.glob(__dir__+"/new/*", File::FNM_DOTMATCH).select do |path|
    path =~ /\.erb$/
  end
  erbs.each do |erb|
    erb_contents = File.read(erb)
    open(erb.sub(/^.*\/new\//, '').sub(/\.erb$/, ''), 'w') do |f|
      f.print ERB.new(erb_contents).result(binding)
    end
  end
end

if ARGV[0] == "new"
  if ARGV.length < 2
    print "Requires a project name\n"
    exit
  end

  #We need to make sure there's no such folder so we don't overwrite or filebomb something important
  #Note name can't be a capital letter
  @project_name = ARGV[1]
  if @project_name !~ /[a-z].*/
    print "Invalid project name\n"
    exit
  elsif File.exist?(@project_name)
    print "Something named '#{@project_name}' already exists, remove it or choose a different name.\n"
    exit
  end

  %x[npx create-react-app #{@project_name}]
  Dir.chdir "./#{@project_name}" do
    %x[git init]
    %x[npm install storybook]
    %x[storybook init]

    get_all_copy_dirs.each do |path|
      FileUtils.mkdir_p path
    end

    get_all_copy_files.each do |path|
      `cp #{path} .`
    end

    parse_all_templates
  end
  print "React Project '#{@project_name}' created!\n"
else
  print "Help:\n"\
    "To create a new React project run:\n"\
    "  ReactTi new <project name>\n"
end
