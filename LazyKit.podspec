Pod::Spec.new do |s|
  s.name = 'LazyKit'
  s.version = '1.1.2'
  s.license = 'MIT'
  s.summary = 'Build complex UIKit views and style them using CSS very fast in Swift.'
  s.description  = <<-DESC 
                   LazyKit is a framework that allow you to write fast and easy views. Constructing a view can be long, boring and repetitive, especialy after the n view built. You can now use basic CSS files to style your elements. 
                   DESC
  s.homepage = 'https://github.com/kmalkic/LazyKit'
  s.authors = { 'Kevin Malkic' => 'k_malkic@yahoo.fr' }
  s.source = { :git => 'https://github.com/kmalkic/LazyKit.git', :tag => s.version }
  s.platform = :ios, "8.0"
  s.source_files = 'LazyKit/Classes/**/*.swift'
  s.requires_arc = true
end