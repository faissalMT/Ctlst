require_relative '../lib/templates'
module Template
  def self.short_help
    'help - Displays this help message'
  end

  def self.main(*_args)
    print "Usage: ctlst <command> [<arguments>]\n\n"
    print "Commands:\n"
    print '  ' + short_help + "\n"

    Dir.glob(__dir__ + '/*').select { |f| File.file?(f) && f != __FILE__ }.each do |template|
      require_relative template
      print '  ' + Template.short_help + "\n"
    end
  end
end
