require 'date'
require 'rss'
require 'open-uri'
module Importers
  # This class scrapes the data from the RSS feed: SBS based
  # on the link
  class SBSImporter < BaseImporter
    # This is used to call the superclass to validate the methods being
    # implemented.
    def initialize
      super
    end

    # RETURN THE SOURCE NAME
    def self.source_name
      'SBS'
    end

    # This method scrapes the data from the RSS feed for SBS and passes
    # it into the articles table in the database, having attributes
    # which are accessible via the data scraped.
    def scrape
      @articles = []
      url = 'http://sbs.feedsportal.com/c/34692/f/637525/index.rss'
      open(url) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          # initialize a html sanitizer
          sanitizer = Rails::Html::FullSanitizer.new
          article = Article.create(author: item.author,
                                   title: item.title,
                                   summary: sanitizer.sanitize(item
                                    .description),
                                   imageURL: nil,
                                   source: SBSImporter.source_name,
                                   pubDate: DateTime.parse(item.pubDate.to_s),
                                   link: item.link)
          # DEBUGGING
          puts "Successfully scraped one article:\nTitle:#{article.title}"
          @articles << article
        end
      end
      @articles
    end
  end
end
