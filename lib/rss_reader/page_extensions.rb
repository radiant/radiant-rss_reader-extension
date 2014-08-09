require 'uri'
require 'net/http'
require 'net/https'
require 'feedparser/feedparser'

module RssReader::PageExtensions
  
  def fetch_rss(uri, cache_time)
    c = File.join(ActionController::Base.page_cache_directory, uri.tr(':/','_'))
    if (cached_feed = feed_for(IO.read(c)) rescue nil)
      return cached_feed if File.mtime(c) > (Time.now - cache_time)
      since = File.mtime(c).httpdate
    else
      since = "1970-01-01 00:00:00"
    end
    u = URI::parse(uri)
    begin
      http = Net::HTTP.new(u.host, u.port)
      http.use_ssl = true if u.port == 443
      answer = http.get("#{u.request_uri}", {"If-Modified-Since" => since, 'User-Agent' => "RadiantCMS rss_reader Extension #{RadiantRssReaderExtension::VERSION}"} )
      feed = feed_for(answer.body)
    rescue
      return cached_feed
    end
    case answer.code
    when '304'
      return cached_feed
    when '200'
      File.open(c,'w+') { |fp| fp << answer.body }
      return feed
    else
      raise StandardError, "#{answer.code} #{answer.message}"
    end
  end
  
  def feed_for(str)
    FeedParser::Feed.new(str)
  end

  def cache?
    false
  end

end