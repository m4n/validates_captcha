require 'rake/packagetask'
require 'rake/gempackagetask'
 
# load gemspec like github's gem builder to surface any SAFE issues.
Thread.new {
  require 'rubygems/specification'
  $spec = eval("$SAFE=3\n#{File.read(File.join(File.dirname(__FILE__), 'validates_captcha.gemspec'))}")
}.join
 
Rake::GemPackageTask.new($spec) do |package|
  package.gem_spec = $spec
end

begin
  require 'hanna/rdoctask'
rescue LoadError
  require 'rake/rdoctask'
end

desc 'Generate documentation'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = "Validates Captcha"
  rdoc.main = "README.rdoc"
 
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.options << '--charset' << 'utf-8'
  
  rdoc.rdoc_files.include 'README.rdoc'
  rdoc.rdoc_files.include 'MIT-LICENSE'
  rdoc.rdoc_files.include 'CHANGELOG.rdoc'
  rdoc.rdoc_files.include 'lib/**/*.rb'
  rdoc.rdoc_files.exclude 'lib/validates_captcha/test_case.rb'
  rdoc.rdoc_files.exclude 'lib/validates_captcha/version.rb'
end

require 'rake/testtask'
 
task :default => :test
 
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  #t.verbose = true
  #t.warning = true
end

Dir['tasks/**/*.rake'].each { |tasks_file| load tasks_file }

