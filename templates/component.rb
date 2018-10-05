require_relative '../lib/templates'

module Template
  def self.main(*args)
    @component_class_name = args[0]

    Templates.create('component', "src/Component/#{@component_class_name}", binding)
    print "Component '#{@component_class_name}' created!\n"
  end
end
