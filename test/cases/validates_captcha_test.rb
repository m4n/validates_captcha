require 'test_helper'

class ValidatesCaptchaTest < ValidatesCaptcha::TestCase
  test "defines a class level #version method" do
    assert_respond_to ValidatesCaptcha, :version
  end
  
  test "class level #version method returns a valid version" do
    assert_match /^\d+\.\d+\.\w+$/, ValidatesCaptcha.version
  end  
  
  test "defines a class level #image_generator method" do
    assert_respond_to ValidatesCaptcha, :image_generator
  end
  
  test "defines a class level #image_generator= method" do
    assert_respond_to ValidatesCaptcha, :image_generator=
  end  
  
  test "defines a class level #string_generator method" do
    assert_respond_to ValidatesCaptcha, :string_generator
  end
  
  test "defines a class level #string_generator= method" do
    assert_respond_to ValidatesCaptcha, :string_generator=
  end  
  
  test "defines a class level #reversible_encrypter method" do
    assert_respond_to ValidatesCaptcha, :reversible_encrypter
  end
  
  test "defines a class level #reversible_encrypter= method" do
    assert_respond_to ValidatesCaptcha, :reversible_encrypter=
  end  
  
  test "defines a class level #middleware method" do
    assert_respond_to ValidatesCaptcha, :middleware
  end
  
  test "defines a class level #middleware= method" do
    assert_respond_to ValidatesCaptcha, :middleware=
  end  
  
  test "defines a class level #generate_captcha_code method" do
    assert_respond_to ValidatesCaptcha, :generate_captcha_code
  end
  
  test "class level #generate_captcha_code returns a string" do
    assert_kind_of String, ValidatesCaptcha.generate_captcha_code
  end  
  
  test "defines a class level #generate_captcha_image method" do
    assert_respond_to ValidatesCaptcha, :generate_captcha_image
  end
  
  test "defines a class level #captcha_image_file_extension method" do
    assert_respond_to ValidatesCaptcha, :captcha_image_file_extension
  end
  
  test "result of #captcha_image_file_extension should equal result of #image_generator.image_file_extension" do
    result1 = ValidatesCaptcha.captcha_image_file_extension
    result2 = ValidatesCaptcha.image_generator.image_file_extension
    
    assert_not_nil result1
    assert_not_nil result2
    assert_equal result1, result2
  end
  
  test "defines a class level #captcha_image_mime_type method" do
    assert_respond_to ValidatesCaptcha, :captcha_image_mime_type
  end
  
  test "result of #captcha_image_mime_type should equal result of #image_generator.image_mime_type" do
    result1 = ValidatesCaptcha.captcha_image_mime_type
    result2 = ValidatesCaptcha.image_generator.image_mime_type
    
    assert_not_nil result1
    assert_not_nil result2
    assert_equal result1, result2
  end
  
  test "defines a class level #encrypt_captcha_code method" do
    assert_respond_to ValidatesCaptcha, :encrypt_captcha_code
  end
  
  test "given the same argument, result of #encrypt_captcha_code should equal result of #reversible_encrypter.encrypt" do
    result1 = ValidatesCaptcha.encrypt_captcha_code('123456')
    result2 = ValidatesCaptcha.reversible_encrypter.encrypt('123456')
    
    assert_not_nil result1
    assert_not_nil result2
    assert_equal result1, result2
  end  
  
  test "defines a class level #decrypt_captcha_code method" do
    assert_respond_to ValidatesCaptcha, :decrypt_captcha_code
  end
  
  test "given the same argument, result of #decrypt_captcha_code should equal result of #reversible_encrypter.decrypt" do
    encrypted_code = ValidatesCaptcha.encrypt_captcha_code('123456')
    
    result1 = ValidatesCaptcha.decrypt_captcha_code(encrypted_code)
    result2 = ValidatesCaptcha.reversible_encrypter.decrypt(encrypted_code)
    
    assert_not_nil result1
    assert_not_nil result2
    assert_equal result1, result2
  end
  
  test "defines a class level #captcha_image_path method" do
    assert_respond_to ValidatesCaptcha, :captcha_image_path
  end
  
  test "given the same argument, result of #captcha_image_path should equal result of #middleware.image_path" do
    result1 = ValidatesCaptcha.captcha_image_path('123456')
    result2 = ValidatesCaptcha.middleware.image_path('123456')
    
    assert_not_nil result1
    assert_not_nil result2
    assert_equal result1, result2
  end
  
  test "defines a class level #regenerate_captcha_path method" do
    assert_respond_to ValidatesCaptcha, :regenerate_captcha_path
  end
  
  test "result of #regenerate_captcha_path should equal result of #middleware.regenerate_path" do
    result1 = ValidatesCaptcha.regenerate_captcha_path
    result2 = ValidatesCaptcha.middleware.regenerate_path
    
    assert_not_nil result1
    assert_not_nil result2
    assert_equal result1, result2
  end
end
