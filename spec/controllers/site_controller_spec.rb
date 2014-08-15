require 'spec_helper'
include Webrat::Matchers

describe SiteController do
  dataset :rss_reader_pages

  it "should read RSS feed generated by Radiant" do
    get :show_page, :url => 'news-feed'
    response.should be_success
    response.body.should include('http://www.example.com/news/article-3/')
  end
  
  describe "fetching and formatting feeds" do
    
    begin
      pages = Page.find_by_slug('news-feed-pages').children
    rescue NoMethodError => error_msg
      puts "\n<h1>Unable to access pages - feed pages depend on viable internet connection.</h1>\n\n"
    end
    
    pages.each do |page|
  
      describe "on #{page.title}" do
        
        before :each do
          get :show_page, :url => "news-feed-pages/#{page.slug}"
        end
        it "should render page from external feed" do 
          response.should be_success
        end
        it "should have the usual feed parts" do
          [:title, :uri, :link, :content].each do |attr|
            response.body.should have_selector('div', :class => "#{attr}") do |att|
              att.should_not be_blank
            end
          end
        end
      end
    end 
  end
  
  describe "fetching, formatting and filtering feeds" do
 
    term = 'extension'
    
    [1,2,3].each do |num|
      it "should limit to #{num} feed item with attribute 'limit=\"#{num}\"'" do 
        get :show_page, :url => "news-feed-page-limit-#{num}"
        response.should be_success
        response.body.should have_selector('div', :class => "title", :count => num)
        response.body.should have_selector('div', :class => "content", :count => num)
      end
    end
    it "should retrieve only items with '#{term}' in the title" do 
      get :show_page, :url => "news-feed-page-by-words-in-title"
      response.should be_success
      response.body.should have_selector('div', :class => "title") do |title|
        title.should contain("#{term}")
      end
    end
    it "should retrieve only items without '#{term}' in the title" do 
      get :show_page, :url => "news-feed-page-by-words-not-in-title"
      response.should be_success
      response.body.should have_selector('div', :class => "title") do |title|
        title.should_not contain("#{term}")
      end
    end
    it "should retrieve only items with '#{term}' in the content" do 
      get :show_page, :url => "news-feed-page-by-words-in-content"
      response.should be_success
      response.body.should have_selector('div', :class => "content") do |content|
        content.should contain("#{term}")
      end
    end
    it "should retrieve only items without '#{term}' in the content" do 
      get :show_page, :url => "news-feed-page-by-words-not-in-content"
      response.should be_success
      response.body.should have_selector('div', :class => "content") do |content|
        content.should_not contain("#{term}")
      end
    end    
    
  end

end