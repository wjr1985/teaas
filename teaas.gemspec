Gem::Specification.new do |s|
  s.name        = 'teaas'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = "Total Emojis as a Service"
  s.description = "Gem to manipulate emoji-sized images"
  s.authors     = ["Bill Rastello"]
  s.email       = 'github@billrastello.com'
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.homepage    = 'https://www.github.com/wjr1985/teaas/'

  s.add_runtime_dependency 'rmagick', '~> 2.15'
  s.add_development_dependency 'rspec', '~> 3.4'
end
