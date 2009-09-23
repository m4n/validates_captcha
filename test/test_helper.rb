$:.unshift File.dirname(__FILE__) + '/../../lib'

require 'rubygems'
require 'test/unit'

require 'validates_captcha'

begin
  require 'ruby-debug'
  Debugger.start
rescue LoadError
end

