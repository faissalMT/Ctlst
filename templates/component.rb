require_relative '../lib/templates'

module Template
  def self.short_help
    'component [name] - Creates a component in src/Component (with tests & stories)'
  end

  def self.main(*args)
    @component_class_name = args[0]

    Templates.create('component', "src/Component/#{@component_class_name}", binding)
    print "Component '#{@component_class_name}' created!\n"
  end
end
