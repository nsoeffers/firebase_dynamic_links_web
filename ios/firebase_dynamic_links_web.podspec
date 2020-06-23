Pod::Spec.new do |s|
    s.name             = 'firebase_dynamic_links_web'
    s.version          = '0.0.1'
    s.summary          = 'No-op implementation of firebase_dynamic_links_web web plugin to avoid build issues on iOS'
    s.description      = <<-DESC
  temp fake firebase_dynamic_links_web plugin
                         DESC
    s.homepage         = 'https://github.com/nsoeffers/firebase_dynamic_links_web'
    s.license          = { :file => '../LICENSE' }
    s.author           = { 'Niels Soeffers' => 'nsoeffers@gmail.com' }
    s.source           = { :path => '.' }
    s.source_files = 'Classes/**/*'
    s.public_header_files = 'Classes/**/*.h'
    s.dependency 'Flutter'

    s.ios.deployment_target = '8.0'
  end
