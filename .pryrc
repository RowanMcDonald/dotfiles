ENV['HOME'] ||= ENV['USERPROFILE'] || File.dirname(__FILE__)
puts 'Loading ~/.pryrc:'

class String; def tilde; sub ENV['HOME'], '~'; end; end
def rails?; defined?(Rails); end
def rails_console?; rails? && Rails.const_defined?("Console"); end
@pryrc_settings = 0
def set(msg, list = []); yield; puts "   #{@pryrc_settings += 1}. #{msg.call}"; list.each { |item| puts "      - #{item}" }; end

set -> { "Pry.editor = #{Pry.editor}" } do
  Pry.editor = ENV['VISUAL']
end


set -> { "Pry.config.history.file = #{Pry.config.history.file.tilde}" } do
  local_history = `git rev-parse --show-toplevel`.strip + '/tmp/history.rb' if rails?

  Pry.config.history.file = local_history || File.expand_path('~/.history.rb')
end





LOG_LEVELS = [:debug, :info, :warn, :error, :fatal, :unknown]
set -> { "Overridding rails rails logger, Rails.logger.level = #{LOG_LEVELS[Rails.logger.level]}" } do
  Rails.logger = Logger.new(STDOUT).tap do |logger|
    logger.formatter = proc { |sev, time, progname, msg| "[#{sev}] #{' ' * (5 - sev.length)}- #{msg} at #{time}\n" }
    logger.level = Logger::ERROR if rails_console?
  end
  Rails.application.config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")
end if rails? && Rails.env.development?




set -> { "Loading plugins: #{Pry.plugins.keys.map{|s| 'pry-' + s }.join(', ')}" } do
  Pry.load_plugins if Pry.config.should_load_plugins
end




set -> { "Adding Array#first!" } do
  class Array
    def first!
      raise 'more than one element' if length > 1
      self[0]
    end
  end
end

set -> { "Adding html-view" } do
  Pry.config.commands.command 'html-view', 'Write input to and html file and open it' do |input|
    input = input ? target.eval(input) : _pry_.last_result

    require 'tempfile'
    file = Tempfile.new(['pry-result', '.html'])
    begin
      file.write(input)
      file.rewind
      `open #{file.path}`
    ensure
      file.unlink
    end
  end
end

remove_instance_variable '@pryrc_settings'
puts "\n"
