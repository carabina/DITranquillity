Pod::Spec.new do |s|

  s.name         = 'DITranquillity'
  s.version      = '0.0.2'
  s.summary      = 'DITranquillity - Dependency injection for iOS (Swift) '

  s.description  = <<-DESC
  					Prototype Dependency injection for iOS (Swift). 
            	DESC

  s.homepage     = 'https://github.com/ivlevAstef/DITranquillity'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.documentation_url = 'https://github.com/ivlevAstef/DITranquillity'

  s.author       = { 'Alexander.Ivlev' => 'ivlev.stef@gmail.com' }
  s.source       = { :git => 'https://github.com/ivlevAstef/DITranquillity.git', :tag => "v#{s.version}" }
  s.requires_arc = true

  s.ios.deployment_target = '8.0'

  s.subspec 'Core' do |core|
    core.source_files = 'Swift/DITranquillity/DITranquillity/Sources/**/*.swift'
  end

  s.default_subspec = 'Core'

end
