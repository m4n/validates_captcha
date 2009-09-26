require 'test_helper'

MW = ValidatesCaptcha::Middleware::Simple

class MiddlewareTest < ValidatesCaptcha::TestCase
  test "defines an instance level #image_path method" do
    assert_respond_to MW.new, :image_path
  end
  
  test "instance level #image_path method accepts an argument" do
    assert_nothing_raised { MW.new.image_path('test') }
  end
  
  test "instance level #image_path method returns a string" do
    assert_kind_of String, MW.new.image_path('test')
  end
  
  test "defines an instance level #regenerate_path method" do
    assert_respond_to MW.new, :image_path
  end
  
  test "instance level #regenerate_path method returns a string" do
    assert_kind_of String, MW.new.regenerate_path
  end
  
  test "calling middleware with unrecognized path should have response status 404" do
    result = MW.new.call 'PATH_INFO' => '/unrecognized'
    
    assert_equal 404, result.first
  end
  
  test "calling middleware with recognized path should not have response status 404" do
    result = MW.new.call 'PATH_INFO' => ValidatesCaptcha.captcha_image_path('abc123')
    
    assert_not_equal 404, result.first
  end
  
  test "calling middleware with valid encrypted captcha code should have response status 200" do
    encrypted_code = ValidatesCaptcha.encrypt_captcha_code('hello')
    result = MW.new.call 'PATH_INFO' => "/captchas/#{encrypted_code}"
    
    assert_equal 200, result.first
  end
  
  test "calling middleware with valid encrypted captcha code should have expected content type response header" do
    encrypted_code = ValidatesCaptcha.encrypt_captcha_code('hello')
    result = MW.new.call 'PATH_INFO' => "/captchas/#{encrypted_code}"
    
    assert result.second.key?('Content-Type')
    assert_equal ValidatesCaptcha.captcha_image_mime_type, result.second['Content-Type']
  end
  
  test "calling middleware with invalid encrypted captcha code should have response status 422" do
    result = MW.new.call 'PATH_INFO' => "/captchas/invalid123"
    
    assert_equal 422, result.first
  end
  
  test "calling middleware with regenerate path should have response status 200" do
    result = MW.new.call 'PATH_INFO' => ValidatesCaptcha.regenerate_captcha_path
    
    assert_equal 200, result.first
  end
  
  test "calling middleware with regenerate path should have content type response header set to application/json" do
    result = MW.new.call 'PATH_INFO' => ValidatesCaptcha.regenerate_captcha_path
    
    assert result.second.key?('Content-Type')
    assert_equal 'application/json', result.second['Content-Type']
  end
end
