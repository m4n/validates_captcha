require 'test_helper'

class ModelValidationTest < ValidatesCaptcha::TestCase
  test "defines an accessible attribute named +captcha+" do
    assert Widget.accessible_attributes.include?('captcha')
  end
  
  test "defines an instance level #captcha method" do
    assert_respond_to Widget.new, :captcha
  end
  
  test "defines a instance level #captcha= method" do
    assert_respond_to Widget.new, :captcha=
  end
  
  test "assigned value to #captcha= should equal return value of #captcha" do
    widget = Widget.new
    widget.captcha = 'abc123'
    
    assert_equal 'abc123', widget.captcha
  end
  
  test "defines an accessible attribute named +encrypted_captcha+" do
    assert Widget.accessible_attributes.include?('encrypted_captcha')
  end
  
  test "defines an instance level #encrypted_captcha method" do
    assert_respond_to Widget.new, :encrypted_captcha
  end
  
  test "defines an instance level #encrypted_captcha= method" do
    assert_respond_to Widget.new, :encrypted_captcha=
  end
  
  test "value assigned to #encrypted_captcha= should equal return value of #encrypted_captcha" do
    widget = Widget.new
    widget.encrypted_captcha = 'asdfghjk3456789'
    
    assert_equal 'asdfghjk3456789', widget.encrypted_captcha
  end
  
  test "defines #validate_captcha method callback of kind +validate+" do
    assert Widget.validate_callback_chain.any? { |callback| callback.method == :validate_captcha && callback.kind == :validate }
  end
  
  test "defines a class level with_captcha_validation method" do
    assert_respond_to Widget, :with_captcha_validation
  end
  
  test "not within a #with_captcha_validation block, calling valid? should return true if no captcha is set" do
    widget = Widget.new
    
    assert widget.valid?
  end
  
  test "not within a #with_captcha_validation block, calling valid? should return true if an empty captcha is set" do
    widget = Widget.new
    widget.captcha = '   '
    
    assert widget.valid?
  end
  
  test "not within a #with_captcha_validation block, calling valid? should return true if an invalid captcha is set" do
    widget = Widget.new
    widget.captcha = 'J§$%ZT&/ÖGHJ'
    
    assert widget.valid?
  end
  
  test "not within a #with_captcha_validation block, calling valid? should return true if a valid captcha is set" do
    widget = Widget.new
    widget.captcha = ValidatesCaptcha.decrypt_captcha_code(widget.encrypted_captcha)
    
    assert widget.valid?
  end
  
  test "within a #with_captcha_validation block, calling valid? should return false if no captcha is set" do
    Widget.with_captcha_validation do
      widget = Widget.new
      
      assert !widget.valid?
      assert_equal 1, Array.wrap(widget.errors[:captcha]).size
      assert Array.wrap(widget.errors[:captcha]).first.include?('blank')
    end
  end
  
  test "within a #with_captcha_validation block, calling valid? should return false if an empty captcha is set" do
    Widget.with_captcha_validation do
      widget = Widget.new
      widget.captcha = '   '
      
      assert !widget.valid?
      assert_equal 1, Array.wrap(widget.errors[:captcha]).size
      assert Array.wrap(widget.errors[:captcha]).first.include?('blank')
    end
  end
  
  test "within a #with_captcha_validation block, calling valid? should return false if an invalid captcha is set" do
    Widget.with_captcha_validation do
      widget = Widget.new
      widget.captcha = 'J§$%ZT&/ÖGHJ'
      
      assert !widget.valid?
      assert_equal 1, Array.wrap(widget.errors[:captcha]).size
      assert Array.wrap(widget.errors[:captcha]).first.include?('invalid')
    end
  end
  
  test "within a #with_captcha_validation block, calling valid? should return true if a valid captcha is set" do
    Widget.with_captcha_validation do
      widget = Widget.new
      widget.captcha = ValidatesCaptcha.decrypt_captcha_code(widget.encrypted_captcha)
      
      assert widget.valid?
    end
  end
  
  test "with #with_captcha_validation block, calling valid? before and after the block should return true if valid? returned false within block" do
    widget = Widget.new
    widget.captcha = 'J§$%ZT&/ÖGHJ'
    
    assert widget.valid?
    
    Widget.with_captcha_validation do
      assert !widget.valid?
    end
    
    assert widget.valid?
  end
end
