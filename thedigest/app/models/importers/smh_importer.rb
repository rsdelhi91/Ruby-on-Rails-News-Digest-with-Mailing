require 'date'
require 'rss'
require 'open-uri'
module Importers
  # This class scrapes the data from the RSS feed: Sydney Morning Herald based
  # on the link
  class SMHImporter < BaseImporter
    # This is used to call the superclass to validate the methods being
    # implemented.
    def initialize
      super
    end

    # RETURN THE SOURCE NAME
    def self.source_name
      'Sydney Morning Herald'
    end

    # This method scrapes the data from the RSS feed for the Sydney Morning
    # Herald and passes it into the articles table in the database, having
    # atttributes which are accessible via the data scraped. Since we do not
    # have any authors mentioned for any of the articles being scraped, I
    # have not specified them here. But If we choose another source which
    # does have authors, we can easily add them by including them here.
    def scrape
      @articles = []
      url = 'http://www.smh.com.au/rssheadlines/top.xml'
      open(url) do |rss|
        feed = RSS::Parser.parse(rss, false)
        feed.items.each do |item|
          article = Article.create(title: item.title.to_s,
                                   summary: item.description.to_s
                                   .gsub(/\"/, ''),
                                   link: item.link,
                                   pubDate: DateTime.parse(item.pubDate.to_s),
                                   source: SMHImporter.source_name)
          @articles << article
        end
      end
      @articles
    end
  end
end
