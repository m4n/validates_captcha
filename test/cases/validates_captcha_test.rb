require 'test_helper'

class ValidatesCaptchaTest < Test::Unit::TestCase
  def test_version
    assert_respond_to ValidatesCaptcha, :version
    assert_match /^\d+\.\d+\.\w+$/, ValidatesCaptcha.version
  end
end
