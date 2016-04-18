
require 'rss'
require 'open-uri'
module Importers
  # This class scrapes the data from the RSS feed: Herald Sun based
  # on the link
  class HSImporter < BaseImporter
    # This is used to call the superclass to validate the methods being
    # implemented.
    def init
      super
    end

    # RETURN THE SOURCE NAME
    def self.source_name
      'Herald Sun'
    end

    # This method scrapes the data from the RSS feed for Herald Sun and
    # passes it into the articles table in the database, having attributes
    # which are accessible via the data scraped. This source may provide
    # data which has unexpected symbols in certain places. This is because
    # this parser cannot parse all types of punctuation (possibly non-ASCII)
    # , hence replaces them with symbols. Since we do not have any authors
    # mentioned for any of the articles being scraped, I have not specified
    # them here.
    def scrape
      @articles = []
      url = 'http://feeds.news.com.au/heraldsun/rss/heraldsun_news_technology_2790.xml'
      open(url) do |rss|
        feed = RSS::Parser.parse(rss, false)
        feed.items.each do |item|
          article = Article.create(title: item.title.to_s.tr('"', '\''),
                                   summary: item.description.to_s
                                   .gsub(/&#8217;/, '\'').gsub(/\"/, '\''),
                                   imageURL: item.enclosure.url,
                                   link: item.link,
                                   pubDate: DateTime.parse(item.pubDate.to_s),
                                   source: HSImporter.source_name)
          @articles << article
        end
      end
      @articles
    end
  end
end
