Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'validates_captcha'
  s.version = '0.9.0'
  s.date = '2009-09-26'
  s.summary = "Image captcha verification for Rails using ActiveRecord's validation mechanism"
  s.description = "An image captcha verification approach for Rails apps, directly integrated into ActiveRecord’s validation mechanism and providing helpers for ActionController and ActionView."
 
  s.files = Dir['[A-Z]*', 'lib/**/*', 'test/**/*', 'rails/*']
  s.test_files = Dir['test/**/*']
 
  s.add_dependency 'actionpack', '>= 2.3.2'
  s.add_dependency 'activerecord', '>= 2.3.2'
 
  s.require_path = 'lib'
 
  s.has_rdoc = true
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "MIT-LICENSE", "README.rdoc"]
  s.rdoc_options << '--title' << "Validates Captcha #{s.version}" << '--main' << 'README.rdoc' << '--line-numbers' << '--inline-source' << '--charset' << 'utf-8'
 
  s.author = 'Martin Andert'
  s.email = 'martin@mehringen.de'
  s.homepage = 'http://m4n.github.com/validates_captcha'
  s.rubyforge_project = 'validatecaptcha'
end

