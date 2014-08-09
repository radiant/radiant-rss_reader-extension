class RssReaderPagesDataset < Dataset::Base
  uses :pages
  
  def load

    create_page "News Feed", :body => <<-CONTENT
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:dc="http://purl.org/dc/elements/1.1/">
  <channel>
    <title>Current News</title>
    <link>http://www.example.com<r:url /></link>
    <language>en-us</language>
    <ttl>120</ttl>
    <description>News Articles</description>
    <r:find url="/news/">
    <r:children:each limit="10" order="desc">
        <item>
          <title><r:title /></title>
          <description><r:escape_html><r:content part="main_content" /></r:escape_html></description>
          <pubDate><r:rfc1123_date /></pubDate>
          <guid>http://www.example.com<r:url /></guid>
          <link>http://www.example.com<r:url /></link>
        </item>
    </r:children:each>
    </r:find>
  </channel>
</rss>
      CONTENT

    feed_urls = []
    feed_urls << "https://github.com/radiant/radiant-rss_reader-extension/commits/master.atom"
    feed_urls << "http://rubygems.org/gems/radiant-rss_reader-extension/versions.atom"
    feed_urls << "http://radiantcms.org/rss.xml"  
      
    create_page "News Feed Pages" do
      feed_urls.each do |feed_url|
        create_page "News Feed Page #{feed_urls.index(feed_url).to_s}", :body => <<-CONTENT
<r:feed:items url="#{feed_url}" order="date desc">
  <div class="title"><r:feed:title /></div>
  <div class="uri"><r:feed:uri /></div>
  <div class="link"><r:feed:link /></div>
  <div class="content"><r:feed:content/></div>
</r:feed:items>
          CONTENT
      end
    end
    
    feed_url = feed_urls.last
    
    create_page "News Feed Page Limit 1", :body => <<-CONTENT
<r:feed:items url="#{feed_url}" order="date desc" limit="1">
  <div class="title"><r:feed:title /></div>
  <div class="content"><r:feed:content/></div>
</r:feed:items>
      CONTENT

  create_page "News Feed Page Limit 2", :body => <<-CONTENT
<r:feed:items url="#{feed_url}" order="date desc" limit="2">
<div class="title"><r:feed:title /></div>
<div class="content"><r:feed:content/></div>
</r:feed:items>
    CONTENT

    create_page "News Feed Page Limit 3", :body => <<-CONTENT
<r:feed:items url="#{feed_url}" order="date desc" limit="3">
  <div class="title"><r:feed:title /></div>
  <div class="content"><r:feed:content/></div>
</r:feed:items>
      CONTENT

    create_page "News Feed Page By Words in Title", :body => <<-CONTENT
<r:feed:items url="#{feed_url}" order="date desc" if_title_contains="extension">
  <div class="title"><r:feed:title /></div>
  <div class="content"><r:feed:content/></div>
</r:feed:items>
      CONTENT
    
    create_page "News Feed Page By Words not in Title", :body => <<-CONTENT
<r:feed:items url="#{feed_url}" order="date desc" unless_title_contains="extension">
  <div class="title"><r:feed:title /></div>
  <div class="content"><r:feed:content/></div>
</r:feed:items>
      CONTENT
   
    create_page "News Feed Page By Words in Content", :body => <<-CONTENT
<r:feed:items url="#{feed_url}" order="date desc" if_content_contains="extension">
  <div class="title"><r:feed:title /></div>
  <div class="content"><r:feed:content/></div>
</r:feed:items>
      CONTENT
  
    create_page "News Feed Page By Words not in Content", :body => <<-CONTENT
<r:feed:items url="#{feed_url}" order="date desc" unless_content_contains="extension">
  <div class="title"><r:feed:title /></div>
  <div class="content"><r:feed:content/></div>
</r:feed:items>
      CONTENT
    
  end
end