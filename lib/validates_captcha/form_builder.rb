module ValidatesCaptcha
  module FormBuilder #:nodoc:
    def captcha_image(options = {}) #:nodoc:
      @template.captcha_image @object_name, options.merge(:object => @object)
    end
    
    def captcha_field(options = {}) #:nodoc:
      @template.captcha_field @object_name, options.merge(:object => @object)
    end
    
    def regenerate_captcha_link(options = {}, html_options = {}) #:nodoc:
      @template.regenerate_captcha_link @object_name, options.merge(:object => @object), html_options
    end
  end
end

