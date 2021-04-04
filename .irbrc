# -*- mode: ruby -*- vim:set ft=ruby:
#
puts 'Loading ~/.irbrc'
ENV['HOME'] ||= ENV['USERPROFILE'] || File.dirname(__FILE__)

# %w(rubygems pry).each do |lib|
#   begin
#     require lib
#   rescue LoadError
#     puts "#{lib} not installed"
#   end
# end

# (Pry.start; exit) if defined?(Pry)

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:LOAD_MODULES] |= %w(irb/completion stringio enumerator ostruct)
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = if defined?(Rails)
                            `git rev-parse --show-toplevel`.strip + '/tmp/history.rb'
                          else
                            File.expand_path('~/.history.rb')
                          end
