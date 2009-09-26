module ValidatesCaptcha
  module ModelValidation
    def self.included(base) #:nodoc:
      base.extend ClassMethods
      base.send :include, InstanceMethods
      
      base.class_eval do
        attr_accessible :captcha, :encrypted_captcha
        attr_accessor :captcha
        attr_writer :encrypted_captcha
        
        validate :validate_captcha, :if => :validate_captcha?
      end
    end
    
    module ClassMethods
      # Activates captcha validation on entering the block and deactivates 
      # captcha validation on leaving the block.
      #
      # Example:
      #
      #   User.with_captcha_validation do
      #     @user = User.new(...)
      #     @user.save
      #   end
      def with_captcha_validation(&block)
        self.validate_captcha = true
        result = yield
        self.validate_captcha = false
        result
      end
          
      # Returns +true+ if captcha validation is activated, otherwise +false+.
      def validate_captcha? #:nodoc:
        @validate_captcha == true
      end
      
      private
        def validate_captcha=(value) #:nodoc:
          @validate_captcha = value
        end
    end
    
    module InstanceMethods #:nodoc:
      def encrypted_captcha #:nodoc:
        return @encrypted_captcha unless @encrypted_captcha.blank?
        @encrypted_captcha = ValidatesCaptcha.encrypt_captcha_code(ValidatesCaptcha.generate_captcha_code)
      end
      
      private      
        def validate_captcha? #:nodoc:
          self.class.validate_captcha?
        end
        
        def validate_captcha #:nodoc:
          errors.add(:captcha, :blank) and return if captcha.blank?
          errors.add(:captcha, :invalid) unless captcha_valid?
        end
      
        def captcha_valid? #:nodoc:
          ValidatesCaptcha.encrypt_captcha_code(captcha) == encrypted_captcha
        end        
    end
  end
end

