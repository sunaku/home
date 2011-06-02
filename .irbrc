# Run `gem install awesome_print` for 'ap' library.

#-----------------------------------------------------------------------------
# identity
#-----------------------------------------------------------------------------

interpreter = (RUBY_DESCRIPTION rescue RUBY_VERSION)
puts "### #{interpreter}"

if RUBY_VERSION < '1.9'
  begin
    require 'rubygems'
  rescue LoadError
    warn '### RubyGems is not available!'
  end
end

#-----------------------------------------------------------------------------
# appearance
#-----------------------------------------------------------------------------

require 'pp'
pretty_printer = 'pp'

begin
  require 'ap'
  pretty_printer = 'ap'
rescue LoadError
end

IRB::Irb.class_eval do
  define_method :output_value do
    __send__ pretty_printer, @context.last_value
  end
end

#-----------------------------------------------------------------------------
# interaction
#-----------------------------------------------------------------------------

IRB.conf[:PROMPT_MODE] = :SIMPLE

require 'irb/completion'
IRB.conf[:AUTO_INDENT] = true

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 10_000
