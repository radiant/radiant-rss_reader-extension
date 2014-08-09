require 'spec_helper'

describe "RssReader::PageExtensions" do
  dataset :rss_reader_pages
  
  describe "Feed Page" do
    before :all do
      @page = pages(:news_feed)
    end
    it "should be valid" do
      @page.should be_valid
      @page.published?.should be_true
    end
    it "should have 1 page part" do
      @page.parts.count.should == 1
    end
    it "should have XML content" do
      @page.parts[0].content.should include('<?xml version="1.0" encoding="UTF-8"?>')
    end
  end
    
  feeds = {}  
  feeds['atom'] = "http://rubygems.org/gems/radiant-rss_reader-extension/versions.atom"
  feeds['rss'] = "http://radiantcms.org/rss.xml"
  
  feeds.each_pair do |feed_type,feed_url|
    
    describe "#{feed_type.capitalize} Feed" do 
      before :all do
        @page = pages(:home)
        @feed = @page.fetch_rss("#{feed_url}", 900)
      end
      [:title, :encoding, :xml].each do |attr|
        it "should have #{attr}" do
          @feed.send("#{attr}").should_not be_blank
        end
      end
      it "should have correct type" do
        @feed.type.should == feed_type
      end
      it "should have at least one item" do
        @feed.items.count.should > 0
      end
      describe "First Item" do
        before :all do
          @item = @feed.items[0]
        end
        [:title, :xml, :content, :link].each do |attr|
          it "should have #{attr}" do
            @item.send("#{attr}").should_not be_blank
          end
        end
        it "should have a valid date" do
          ParseDate.parsedate("#{@item.date}")[0].should_not be_nil
        end
        it "should have at least 1 creator" do
          @item.creators.count.should > 0
        end
        it "should have a valid link" do
          @item.link.should include(feed_url[0..10])
        end
      end 
    end
  end
  
end