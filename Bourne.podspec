Pod::Spec.new do |s|
  s.name         = "Bourne"
  s.version      = "1.0.0"
  s.summary      = "A JSON parser"
  s.description  = <<-DESC
    Your description here.
  DESC
  s.homepage     = "https://github.com/nanoxd/Bourne"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Fernando Paredes" => "nano@fdp.io" }
  s.social_media_url   = ""
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/nanoxd/Bourne.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
