# Radiant RSS Reader Extension

This is a RadiantCMS extension (originally a behavior by Alessandro Preite Martinez) that adds some tags to fetch and display RSS feeds. It uses the'ruby-feedparser' module, and it is able to cache the raw feed data and to only fetch the new feed if it has been modified (using the If-Modified-Since HTTP header).

## Installation

Add `gem "radiant-rss_reader-extension", "~> 1.0.0"` to your Gemfile and run `bundle install`


## Usage

Use it in your page like this (just an example):

    <dl>
     <r:feed:items url="http://www.somefeed.com/rss" limit="5">
      <dt><r:feed:link /> - by <r:feed:creator />, <r:feed:date format="%b %d"/></dt>
      <dd><r:feed:content /></dd>
     </r:feed:items>
    </dl>
    
You can also order by some feed entry attribute other than the date:

    <ul>

      <r:feed:items
          url="http://feeds.boingboing.net/boingboing/iBag" 
          order="creator ASC">

        <li><r:feed:link /></li>

      </r:feed:items>

    </ul>
    
And you can do headers to mark off sections:

    <ul>

      <r:feed:items
          url="http://feeds.boingboing.net/boingboing/iBag" 
          order="creator ASC">

        <r:feed:header for="creator">
          <h2><r:feed:creator /></h2>
        </r:feed:header>

        <li><r:feed:link /></li>

      </r:feed:items>

    </ul>

You can sort items and group headers by date, title, content, creator, or link (i.e. the URL of the item). There are more things you can do, which are documented in `rss_reader.rb`.

## [Contributors](https://github.com/radiant/radiant-rss_reader-extension/graphs/contributors)

#### Original Author:  
* Alessandro Preite Martinez (ale@incal.net)

#### Port to Extension:

* BJ Clark (bjclark@scidept.com, http://www.scidept.com/)
* Loren Johnson (loren@fn-group.com, http://www.fn-group.com)

#### Update to new Extension Architecture, Gemify:

* Andrew vonderLuft (avonderluft@avlux.net, https://avlux.net)

#### Modifications:

* James MacAulay (jmacaulay@gmail.com, http://jmacaulay.net/)
* Michael Hale (mikehale@gmail.com, http://michaelahale.com/)
* Bryan Liles (iam@smartic.us, http://smartic.us/)

## [History](https://github.com/radiant/radiant-rss_reader-extension/commits/master)

## License

Creative Commons Attribution-Share Alike 2.5 License


