require 'date'
require 'rss'
require 'open-uri'
module Importers
  # This class scrapes the data from the RSS feed: ABC based
  # on the link
  class ABCImporter < BaseImporter
    # This is used to call the superclass to validate the methods being
    # implemented.
    def initialize
      super
    end

    # RETURN THE SOURCE NAME
    def self.source_name
      'ABC'
    end

    # This method scrapes the data from the RSS feed for ABC and passes
    # it into the articles table in the database, having attributes which
    # are accessible via the data scraped.
    def scrape
      @articles = []
      # CODE HERE
      url = 'http://www.abc.net.au/sport/syndicate/sport_all.xml'
      open(url) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          title = item.title
          summary = item.description
          pub_date = DateTime.parse(item.pubDate.to_s)
          link = item.link
          # set different items to article object
          # how to get author, image ?
          article = Article.create(author: nil,
                                   title: title,
                                   summary: summary,
                                   imageURL: nil,
                                   source: ABCImporter.source_name,
                                   pubDate: pub_date,
                                   link: link)
          @articles << article
          # DEBUGGING
          puts "Successfully scraped one article:\nTitle:#{article.title}"
        end
      end
      @articles
    end
  end
end
