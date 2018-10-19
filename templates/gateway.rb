require_relative '../lib/templates'

module Template
  def self.short_help
    'gateway [name] - Creates a gateway in src/Gateway (with tests)'
  end

  def self.main(*args)
    @gateway_class_name = args[0]

    Templates.create('gateway', "src/Gateway/#{@gateway_class_name}", binding)
    print "Gateway '#{@gateway_class_name}' created!\n"
  end
end
