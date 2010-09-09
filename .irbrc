# Run `gem install awesome_print` for 'ap' library.

interpreter = (RUBY_DESCRIPTION rescue RUBY_VERSION)
puts "### #{interpreter}"

if RUBY_VERSION < '1.9'
  begin
    require 'rubygems'
  rescue LoadError
    warn '### RubyGems is not available!'
  end
end

pretty_printer = %w[ap pp].find do |library|
  begin
    require library
    true
  rescue LoadError
    false
  end
end

if pretty_printer
  IRB::Irb.class_eval do
    define_method :output_value do
      __send__ pretty_printer, @context.last_value
    end
  end
end

IRB.conf[:PROMPT_MODE] = :SIMPLE

require 'irb/completion'
IRB.conf[:AUTO_INDENT] = true

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 10_000
