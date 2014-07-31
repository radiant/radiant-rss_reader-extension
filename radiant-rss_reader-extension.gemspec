# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "radiant-rss_reader-extension"

Gem::Specification.new do |s|
  s.name        = "radiant-rss_reader-extension"
  s.version     = RadiantRssReaderExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = RadiantRssReaderExtension::AUTHORS
  s.email       = RadiantRssReaderExtension::EMAIL
  s.homepage    = RadiantRssReaderExtension::URL
  s.summary     = RadiantRssReaderExtension::SUMMARY
  s.description = RadiantRssReaderExtension::DESCRIPTION

  # Define gem dependencies here.
  # Don't include a dependency on radiant itself: it causes problems when radiant is in vendor/radiant.
  s.add_dependency "ruby-feedparser", "0.7.0"

  ignores = if File.exist?('.gitignore')
    File.read('.gitignore').split("\n").inject([]) {|a,p| a + Dir[p] }
  else
    []
  end
  s.files         = Dir['**/*'] - ignores
  s.test_files    = Dir['test/**/*','spec/**/*','features/**/*'] - ignores
  # s.executables   = Dir['bin/*'] - ignores
  s.require_paths = ["lib"]
end
