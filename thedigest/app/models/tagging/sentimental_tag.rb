require 'bundler/setup'
require 'rubygems'
module Tagging
  # This class is used to generate tags using the tagging gem Sentimental. It
  # extracts tags based on the kind of sentiments the Article possesses. This
  # is used to generate semantic tags for our scraped articles.
  class SentimentalTag < BaseTagger
    def initialize
      super
    end

    # This method is used to generate tags for the scraped articles passed to it
    # by using the Sentimental gem. If the articles has a positive sentiment
    # then we place the tag "Happy", else if we get a negative sentiment then
    # we place the tag "Sad".
    def create_tags(article)
      tag_arr = []
      Sentimental.load_defaults
      Sentimental.threshold = 0
      s = Sentimental.new
      sentiment_tag = s.get_sentiment(article)
      if sentiment_tag.to_s.eql? 'positive'
        tag_arr << 'Happy'
      elsif sentiment_tag.to_s.eql? 'negative'
        tag_arr << 'Sad'
      end
      puts "Sentimental sentiment:#{sentiment_tag}"
      tag_arr
    end
  end
end
