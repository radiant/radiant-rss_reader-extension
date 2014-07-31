require "radiant-rss_reader-extension"

class RssReaderExtension < Radiant::Extension
  version     RadiantRssReaderExtension::VERSION
  description RadiantRssReaderExtension::DESCRIPTION
  url         RadiantRssReaderExtension::URL

  def activate
    cache_dir = ActionController::Base.page_cache_directory
    Dir.mkdir(cache_dir) unless File.exist?(cache_dir)
    Page.send :include, RssReader
  end
end
