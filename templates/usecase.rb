require_relative '../lib/templates'

module Template
  def self.short_help
    'usecase [name] - Creates a usecase in src/Usecase (with tests)'
  end

  def self.main(*args)
    @usecase_class_name = args[0]

    Templates.create('usecase', "src/UseCase/#{@usecase_class_name}", binding)
    print "Use case '#{@usecase_class_name}' created!\n"
  end
end
