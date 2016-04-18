require 'rubygems'
require 'bundler/setup'
module Tagging
  # This class is used to generate tags using the tagging gem highscore. It
  # generates tags by providing a score to each word in an article then picking
  # the ones which are most relevant.
  class HighscoreTag < BaseTagger
    def initialize
      super
    end

    # This method is used to generate tags by assigning a score to each word
    # of the article and filtering them using the blacklist stated below. It a
    # word has lesser weight but has length greater than 4 letters then we
    # consider that word as a tag else only relevant words will be used to
    # generate tags.
    def create_tags(article)
      keywords = article.keywords(Highscore::Blacklist
        .load(%w(their are may there and)))
      tags_arr = []
      keywords.rank.each do |k|
        if "#{k.weight}".to_i < 2
          tags_arr.push("#{k.text}") if "#{k.text}".length > 4
        end
      end
      puts "#{tags_arr}"
      tags_arr
    end
  end
end
