require 'fileutils'
require 'ERB'

module Templates
  def self.create(template, dir, scope)
    create_template_dirs(template, dir)
    copy_template_verbatim_files(template, dir)
    copy_template_parsed_erbs(template, dir, scope)
  end

  def self.create_template_dirs(template, dir)
    Dir.glob(__dir__ + "/../templates/#{template}/**/*", File::FNM_DOTMATCH).select do |path|
      File.directory?(path)
    end.each do |path|
      FileUtils.mkdir_p "#{dir}/#{path.sub(/^.*\/templates\/#{template}\//, '')}"
    end
  end

  def self.copy_template_verbatim_files(template, dir)
    Dir.glob(__dir__ + "/../templates/#{template}/**/*", File::FNM_DOTMATCH).reject do |path|
      path =~ /^\.$|^\.\.$|\.erb$/ || File.directory?(path)
    end.each do |path|
      `cp #{path} #{dir}/#{path.sub(/^.*\/templates\/#{template}\//, '')}`
    end
  end

  def self.copy_template_parsed_erbs(template, dir, scope)
    erbs = Dir.glob(__dir__ + "/../templates/#{template}/*", File::FNM_DOTMATCH).select do |path|
      path =~ /\.erb$/
    end
    erbs.each do |erb|
      erb_contents = File.read(erb)
      open("#{dir}/#{erb.sub(/^.*\/templates\/#{template}\//, '').sub(/\.erb$/, '')}", 'w') do |f|
        f.print ERB.new(erb_contents).result(scope)
      end
    end
  end
end
