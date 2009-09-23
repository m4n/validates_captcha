require 'test_helper'

class ValidatesCaptchaTest < ValidatesCaptcha::TestCase
  test "defines a class level #version method" do
    assert_respond_to ValidatesCaptcha, :version
  end
  
  test "class level #version method returns a valid version" do
    assert_match /^\d+\.\d+\.\w+$/, ValidatesCaptcha.version
  end
end
