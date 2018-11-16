require_relative '../lib/templates'
module Template
  def self.short_help
    'new [name] - Create a new React.js app with a full development environment'
  end

  def self.main(*args)
    if args.empty?
      print "Requires a project name\n"
      exit
    end

    @project_name = args[0]
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
      `npm install isomorphic-fetch`
      `npm i --save-dev storybook nock enzyme enzyme-adapter-react-16 @storybook/react@alpha @storybook/cli@alpha graceful-fs`
      `storybook init`

      Templates.create('new', '.', binding)
    end
    print "React Project '#{@project_name}' created!\n"
  end
end
