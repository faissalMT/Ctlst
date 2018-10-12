require_relative '../lib/templates'

module Template
  def self.short_help
    'domain [name] - Creates a domain in src/Domain (with tests)'
  end

  def self.main(*args)
    @domain_class_name = args[0]

    Templates.create('domain', "src/Domain/#{@domain_class_name}", binding)
    print "Domain '#{@domain_class_name}' created!\n"
  end
end
