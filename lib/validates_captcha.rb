#--
# Copyright (c) 2009 Martin Andert
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++


# This module contains the getters and setters for the backend classes: 
# image/string generator, reversible encrypter, and Rack middleware. This 
# allows you to replace them with your custom implementations. For more 
# information on how to bring Validates Captcha to use your own 
# implementation instead of the default one, consult the documentation 
# for the specific default class.
# 
# This module also contains convenience wrapper methods for all the 
# methods provided by the configured backend classes. These wrapper 
# methods form the API that is visible to the outside world and that 
# all backend classes use for internal communication.
module ValidatesCaptcha
  autoload :ModelValidation, 'validates_captcha/model_validation'
  autoload :ControllerValidation, 'validates_captcha/controller_validation'
  autoload :FormHelper, 'validates_captcha/form_helper'
  autoload :FormBuilder, 'validates_captcha/form_builder'
  autoload :TestCase, 'validates_captcha/test_case'
  autoload :VERSION, 'validates_captcha/version'
  
  module ImageGenerator
    autoload :Simple, 'validates_captcha/image_generator/simple'
  end
  
  module StringGenerator
    autoload :Simple, 'validates_captcha/string_generator/simple'
  end
  
  module ReversibleEncrypter
    autoload :Simple, 'validates_captcha/reversible_encrypter/simple'
  end
  
  module Middleware
    autoload :Simple, 'validates_captcha/middleware/simple'
  end  
  
  @@image_generator = nil
  @@string_generator = nil
  @@reversible_encrypter = nil
  @@middleware = nil
  
  class << self
    # Returns ValidatesCaptcha's current version number.
    def version
      ValidatesCaptcha::VERSION::STRING
    end
    
    # Returns the current captcha image generator. Defaults to an 
    # instance of the ValidatesCaptcha::ImageGenerator::Simple class.
    def image_generator
      @@image_generator ||= ImageGenerator::Simple.new
    end

    # Sets the current captcha image generator. Used to set a custom 
    # image generator.
    def image_generator=(generator)
      @@image_generator = generator
    end
    
    # Returns the current captcha string generator. Defaults to an 
    # instance of the ValidatesCaptcha::StringGenerator::Simple class.
    def string_generator
      @@string_generator ||= StringGenerator::Simple.new
    end

    # Sets the current captcha string generator. Used to set a 
    # custom string generator.
    def string_generator=(generator)
      @@string_generator = generator
    end
    
    # Returns the current captcha reversible encrypter. Defaults to an 
    # instance of the ValidatesCaptcha::ReversibleEncrypter::Simple class.
    def reversible_encrypter
      @@reversible_encrypter ||= ReversibleEncrypter::Simple.new
    end

    # Sets the current captcha reversible encrypter. Used to set a 
    # custom reversible encrypter.
    def reversible_encrypter=(encrypter)
      @@reversible_encrypter = encrypter
    end
    
    # Returns the current captcha middleware. Defaults to the 
    # ValidatesCaptcha::Middleware::Simple class.
    def middleware
      @@middleware ||= Middleware::Simple.new
    end

    # Sets the current captcha middleware. Used to set a custom 
    # middleware.
    def middleware=(middleware)
      @@middleware = middleware
    end
    
    # Randomly generates a string which can be used as the code 
    # displayed on captcha images. This method internally calls 
    # +string_generator.generate+.
    def generate_captcha_code
      string_generator.generate
    end
    
    # Returns the image data of the generated captcha image. This 
    # method internally calls +image_generator.generate+.
    def generate_captcha_image(code)
      image_generator.generate(code)
    end
    
    # Returns the image file extension of the captcha images. This 
    # method internally calls +image_generator.image_file_extension+.
    def captcha_image_file_extension
      image_generator.image_file_extension
    end
    
    # Returns the image mime type of the captcha images. This 
    # method internally calls +image_generator.image_mime_type+.
    def captcha_image_mime_type
      image_generator.image_mime_type
    end
    
    # Returns the encryption of a cleartext captcha code. This 
    # method internally calls +reversible_encrypter.encrypt+.
    def encrypt_captcha_code(code)
      reversible_encrypter.encrypt(code)
    end
    
    # Returns the decryption of an encrypted captcha code. This 
    # method internally calls +reversible_encrypter.decrypt+.
    def decrypt_captcha_code(encrypted_code)
      reversible_encrypter.decrypt(encrypted_code)
    end
    
    # Returns the captcha image path for a given encrypted code. This 
    # method internally calls +middleware.image_path+.
    def captcha_image_path(encrypted_code)
      middleware.image_path(encrypted_code)
    end
    
    # Returns the path that is used when requesting the regeneration 
    # of a captcha image. This method internally calls 
    # +middleware.regenerate_path+.
    def regenerate_captcha_path
      middleware.regenerate_path
    end
  end
end

