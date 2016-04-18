require 'date'
require 'rss'
require 'open-uri'
module Importers
  # This class scrapes the data from the RSS feed: The Age based
  # on the link.
  class THEAGEImporter < BaseImporter
    # This is used to call the superclass to validate the methods being
    # implemented, and also initialize the URL being used to scrape and
    # set the feed to scrape.
    def initialize
      super
      url = 'http://www.theage.com.au/rssheadlines/top.xml'
      rss = open(url).read
      @feed = RSS::Parser.parse(rss, false)
      @source = @feed.channel.title.to_s
    end

    # RETURN THE SOURCE NAME
    def self.source_name
      'The Age'
    end

    # This method scrapes the data from the RSS feed for The Age and passes
    # it into the articles table in the database, having attributes which
    # are accessible via the data scraped.
    def scrape
      @articles = []
      # CODE HERE
      @feed.items.each do |item|
        # set different items to article object
        article = Article.create(author: nil,
                                 title: item.title.delete(','),
                                 summary: item.description.to_s.delete(','),
                                 imageURL: nil,
                                 source: THEAGEImporter.source_name,
                                 pubDate: DateTime.parse(item.pubDate.to_s),
                                 link: item.link)
        # DEBUGGING
        puts "Successfully scraped one article:\nTitle:#{article.title}"
        @articles << article
      end
      @articles
    end
  end
end
