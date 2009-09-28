require 'openssl'
require 'active_support/secure_random'

module ValidatesCaptcha
  module ReversibleEncrypter
    # This class is responsible for encrypting and decrypting captcha codes. 
    # It internally uses AES256 to do the string encryption/decryption.
    #
    # You can implement your own reversible encrypter by creating a class 
    # that conforms to the method definitions of the example below and 
    # assign an instance of it to ValidatesCaptcha::Provider::Image#reversible_encrypter=.
    #
    # Example for a custom encrypter/decrypter:
    #
    #  class ReverseString # very insecure and easily cracked
    #    def encrypt(code)
    #      code.reverse
    #    end
    #
    #    def decrypt(encrypted_code)
    #      encrypted_code.reverse
    #    rescue SomeKindOfDecryptionError
    #      nil
    #    end
    #  end
    #
    #  ValidatesCaptcha::Provider::Image.reversible_encrypter = ReverseString.new
    #  ValidatesCaptcha.provider = ValidatesCaptcha::Provider::Image.new
    #
    # Please note: The #decrypt method should return +nil+ if decryption fails. 
    class Simple
      KEY = ::ActiveSupport::SecureRandom.hex(32).freeze
      
      def initialize #:nodoc:
        @aes = OpenSSL::Cipher::Cipher.new('AES-256-ECB')
      end
    
      # Encrypts a cleartext string using #key as encryption key. 
      def encrypt(code)
        @aes.encrypt
        @aes.key = KEY
        [@aes.update(code) + @aes.final].pack("m").tr('+/=', '-_ ').strip.gsub("\n", '')
      end
    
      # Decrypts an encrypted string using using #key as decryption key.
      def decrypt(encrypted_code)
        @aes.decrypt
        @aes.key = KEY
        @aes.update((encrypted_code + '=' * (4 - encrypted_code.size % 4)).tr('-_', '+/').unpack("m").first) + @aes.final
      rescue # OpenSSL::CipherError, OpenSSL::Cipher::CipherError
        nil
      end
    end
  end
end
