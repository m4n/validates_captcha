require 'active_support/core_ext/string/bytesize'

module ValidatesCaptcha
  module Middleware
    # This class acts as the Rack middleware that serves the captcha images.
    #
    # You can implement your own middleware by creating a 
    # class that conforms to the method definitions of the example below and 
    # assign an instance of it to ValidatesCaptcha#middleware=.
    #
    # Example for a custom middleware:
    #
    #  class MyMiddleware
    #    def image_path(encrypted_code)
    #      '/captchas/image/' + encrypted_code + ValidatesCaptcha.captcha_image_file_extension
    #    end
    #
    #    def regenerate_path
    #      '/captchas/regenerate'
    #    end
    #
    #    def call(env)
    #      if env['PATH_INFO'] =~ /^\/captchas\/image\/([^\.]+)/
    #        decrypted_code = ValidatesCaptcha.decrypt_captcha_code($1)
    #    
    #        if decrypted_code.nil?
    #          [422, { 'Content-Type' => 'text/html' }, ['Unprocessable Entity']]
    #        else
    #          image_data = ValidatesCaptcha.generate_captcha_image(decrypted_code)
    #        
    #          headers = {
    #            'Content-Length'            => image_data.bytesize.to_s,
    #            'Content-Type'              => ValidatesCaptcha.captcha_image_mime_type,
    #            'Content-Disposition'       => 'inline',
    #            'Content-Transfer-Encoding' => 'binary'
    #          }
    #        
    #          [200, headers, [image_data]]
    #        end
    #      elsif env['PATH_INFO'] == regenerate_path
    #        encrypted_code = ValidatesCaptcha.encrypt_captcha_code(ValidatesCaptcha.generate_captcha_code)
    #        xml = { :encrypted_captcha_code => encrypted_code, :captcha_image_path => image_path(encrypted_code) }.to_xml
    #
    #        [200, { 'Content-Type' => 'application/xml' }, [xml]]
    #      else
    #        [404, { 'Content-Type' => 'text/html' }, ['Not Found']]
    #      end
    #    end
    #  end
    #
    #  ValidatesCaptcha.middleware = MyMiddleware.new
    #    
    class Simple      
      # Returns the captcha image path for a given encrypted code. 
      #
      # This is used by the +captcha_image+ form helper.
      def image_path(encrypted_code)
        "/captchas/#{encrypted_code}#{ValidatesCaptcha.captcha_image_file_extension}"
      end
      
      # Returns the path that is used when requesting the regeneration 
      # of a captcha image. Defaults to '/captchas/regenerate'.
      #
      # This is used by the +regenerate_captcha_link+ form helper.
      def regenerate_path
        '/captchas/regenerate'
      end
      
      # This method is the one called by Rack.
      # 
      # It returns HTTP status 404 if the path is not recognized. If the path is 
      # recognized, it returns HTTP status 200 and delivers the image if it could 
      # successfully decrypt the captcha code, otherwise HTTP status 422.
      #
      # Please take a look at the source code if you want to learn more.
      def call(env)
        if env['PATH_INFO'] =~ /^\/captchas\/([^\.]+)/
          if $1 == 'regenerate'
            encrypted_code = ValidatesCaptcha.encrypt_captcha_code(ValidatesCaptcha.generate_captcha_code)
            json = { :encrypted_captcha_code => encrypted_code, :captcha_image_path => image_path(encrypted_code) }.to_json
            
            [200, { 'Content-Type' => 'application/json' }, [json]]
          else
            decrypted_code = ValidatesCaptcha.decrypt_captcha_code($1)
          
            if decrypted_code.nil?
              [422, { 'Content-Type' => 'text/html' }, ['Unprocessable Entity']]
            else
              image_data = ValidatesCaptcha.generate_captcha_image(decrypted_code)
              
              response_headers = {
                'Content-Length'            => image_data.bytesize.to_s,
                'Content-Type'              => ValidatesCaptcha.captcha_image_mime_type,
                'Content-Disposition'       => 'inline',
                'Content-Transfer-Encoding' => 'binary',
                'Cache-Control'             => 'private'
              }
              
              [200, response_headers, [image_data]]
            end
          end
        else
          [404, { 'Content-Type' => 'text/html' }, ['Not Found']]
        end
      end
    end
  end
end
