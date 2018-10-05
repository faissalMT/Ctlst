#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'
require 'ERB'

def create_template_dirs(template, dir)
  Dir.glob(__dir__ + "/templates/#{template}/**/*", File::FNM_DOTMATCH).select do |path|
    File.directory?(path)
  end.each do |path|
    FileUtils.mkdir_p "#{dir}/#{path.sub(/^.*\/templates\/#{template}\//, '')}"
  end
end

def copy_template_verbatim_files(template, dir)
  Dir.glob(__dir__ + "/templates/#{template}/**/*", File::FNM_DOTMATCH).reject do |path|
    path =~ /^\.$|^\.\.$|\.erb$/ || File.directory?(path)
  end.each do |path|
    p "Path: #{path}"
    `cp #{path} #{dir}/#{path.sub(/^.*\/templates\/#{template}\//, '')}`
  end
end

def copy_template_parsed_erbs(template, dir)
  erbs = Dir.glob(__dir__ + "/templates/#{template}/*", File::FNM_DOTMATCH).select do |path|
    path =~ /\.erb$/
  end
  erbs.each do |erb|
    erb_contents = File.read(erb)
    open("#{dir}/#{erb.sub(/^.*\/templates\/#{template}\//, '').sub(/\.erb$/, '')}", 'w') do |f|
      f.print ERB.new(erb_contents).result(binding)
    end
  end
end

def create_template(template, dir)
  create_template_dirs(template, dir)
  copy_template_verbatim_files(template, dir)
  copy_template_parsed_erbs(template, dir)
end

if ARGV[0] == 'new'
  if ARGV.length < 2
    print "Requires a project name\n"
    exit
  end

  # We need to make sure there's no such folder so we don't overwrite or filebomb something important
  # Note name can't be a capital letter
  @project_name = ARGV[1]
  if @project_name !~ /[a-z].*/
    print "Invalid project name\n"
    exit
  elsif File.exist?(@project_name)
    print "Something named '#{@project_name}' already exists, remove it or choose a different name.\n"
    exit
  end

  `npx create-react-app #{@project_name}`
  Dir.chdir "./#{@project_name}" do
    `git init`
    `npm install storybook`
    `storybook init`

    create_template('new', '.')
  end
  print "React Project '#{@project_name}' created!\n"
else
  print "Help:\n"\
    "To create a new React project run:\n"\
    "  ReactTi new <project name>\n"
end
