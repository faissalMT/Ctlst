require_relative '../lib/templates'
module Template
  def self.short_help
    'help'
  end

  def self.main(*_args)
    print "Help:\n"
    print "\t" + short_help + "\n"

    Dir.glob(__dir__ + '/*').select { |f| File.file?(f) && f != __FILE__ }.each do |template|
      require_relative template
      print "\t" + Template.short_help + "\n"
    end
  end
end
