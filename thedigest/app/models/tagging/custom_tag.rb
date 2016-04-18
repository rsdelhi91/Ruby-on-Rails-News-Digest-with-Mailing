# This module deals with tags
module Tagging
  # This class is used to provide custom tags by extracting nouns from the
  # article title and article summary passed to it. The extraction is performed
  # using regex.
  class CustomTag < BaseTagger
    def initialize
      super
    end

    # This method is used to create tags from the articles with the help of
    # regex. It scans the entire article string passed to it and extracts
    # words which fit the criteeria for being a proper noun. Following which,
    # those words are passed to an array and returned for further processing.
    def create_tags(article)
      tags_arr = []
      regex = /[A-Z][a-z]+|[A-Z]+/
      tags_arr = article.scan regex
      puts "#{tags_arr}"
      tags_arr
    end
  end
end
