Gem::Specification.new do |spec|
  spec.name = 'validates_captcha'
  spec.version = '0.9.0'
  spec.date = '2009-09-26'
  spec.summary = "Image captcha verification for Rails using ActiveRecord's validation mechanism"
  spec.description = "An image captcha verification approach for Rails apps, directly integrated into ActiveRecord’s validation mechanism and providing helpers for ActionController and ActionView."
  spec.email = 'martin@mehringen.de'
  spec.homepage = 'http://github.com/m4n/validates_captcha'
  spec.authors = ['Martin Andert']
  spec.files = ["CHANGELOG", "MIT-LICENSE", "README.rdoc", "Rakefile", "lib/validates_captcha.rb", "lib/validates_captcha/controller_validation.rb", "lib/validates_captcha/form_builder.rb", "lib/validates_captcha/form_helper.rb", "lib/validates_captcha/image_generator/simple.rb", "lib/validates_captcha/middleware/simple.rb", "lib/validates_captcha/model_validation.rb", "lib/validates_captcha/reversible_encrypter/simple.rb", "lib/validates_captcha/string_generator/simple.rb", "lib/validates_captcha/test_case.rb", "lib/validates_captcha/version.rb", "rails/init.rb", "script/console", "test/cases/controller_validation_test.rb", "test/cases/image_generator_test.rb", "test/cases/middleware_test.rb", "test/cases/model_validation_test.rb", "test/cases/reversible_encrypter_test.rb", "test/cases/string_generator_test.rb", "test/cases/validates_captcha_test.rb", "test/test_helper.rb", "validates_captcha.gemspec"]
  spec.test_files = spec.files.select { |file| file[0..4] == 'test/' }
  spec.has_rdoc = true
  spec.extra_rdoc_files = ["CHANGELOG", "MIT-LICENSE", "README.rdoc"]
  spec.rdoc_options << '--title' << "Validates Captcha #{spec.version}" << '--main' << 'README.rdoc' << '--line-numbers' << '--inline-source' << '--charset' << 'utf-8'
  spec.require_paths = ['lib']
  spec.rubygems_version = '1.3.5'

  if spec.respond_to?(:specification_version)
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    spec.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0')
      spec.add_runtime_dependency('actionpack', ['>= 2.3.2'])
      spec.add_runtime_dependency('activerecord', ['>= 2.3.2'])
    else
      spec.add_dependency('actionpack', ['>= 2.3.2'])
      spec.add_dependency('activerecord', ['>= 2.3.2'])
    end
  else
    spec.add_dependency('actionpack', ['>= 2.3.2'])
    spec.add_dependency('activerecord', ['>= 2.3.2'])
  end
end
