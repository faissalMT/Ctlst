require_relative '../lib/templates'

module Template
  def self.main(*args)
    @domain_class_name = args[0]

    Templates.create('domain', "src/Domain/#{@domain_class_name}", binding)
    print "Domain '#{@domain_class_name}' created!\n"
  end
end
