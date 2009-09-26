module ValidatesCaptcha
  module FormHelper
    # Returns an img tag with the src attribute pointing to the captcha image url. 
    #
    # Internally calls Rails' #image_tag helper method, passing the +options+ 
    # argument.
    def captcha_image(object_name, options = {})
      object = options.delete(:object)
      src = ValidatesCaptcha.captcha_image_path(object.encrypted_captcha)
      sanitized_object_name = object_name.to_s.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
      
      options[:alt] ||= 'CAPTCHA'
      options[:id] = "#{sanitized_object_name}_captcha_image"
      
      image_tag src, options
    end
    
    # Returns an input tag of the "text" type tailored for entering the captcha code.
    #
    # Internally calls Rails' #text_field helper method, passing the +object_name+ and 
    # +options+ arguments.
    def captcha_field(object_name, options = {})
      options.delete(:id)
      
      hidden_field(object_name, :encrypted_captcha, options) + text_field(object_name, :captcha, options)
    end
    
    # Returns an anchor tag that makes an AJAX request to fetch a new captcha code and updates 
    # the captcha image after the request is complete.
    # 
    # Internally calls Rails' #link_to_remote helper method, passing the +options+ and 
    # +html_options+ arguments. So it relies on the Prototype javascript framework 
    # to be available on the web page.
    #
    # The anchor text defaults to 'Regenerate Captcha'. You can set this to a custom value 
    # providing a +:text+ key in the +options+ hash.
    def regenerate_captcha_link(object_name, options = {}, html_options = {})
      options.symbolize_keys!
      
      object = options.delete(:object)
      text = options.delete(:text) || 'Regenerate Captcha'      
      sanitized_object_name = object_name.to_s.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
      
      url = ValidatesCaptcha.regenerate_captcha_path
      success = "var result = request.responseJSON; $('#{sanitized_object_name}_captcha_image').src = result.captcha_image_path; $('#{sanitized_object_name}_encrypted_captcha').value = result.encrypted_captcha_code;"
      
      link_to_remote text, options.reverse_merge(:url => url, :method => :get, :success => success), html_options
    end
  end
end

