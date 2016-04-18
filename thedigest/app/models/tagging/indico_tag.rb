require 'rubygems'
require 'bundler/setup'
module Tagging
  # This class is used to generate tags using the tagging gem Indico. It
  # extracts two types of tags, namely: keywords and tags. We consider both of
  # them to generate relevant tags for our scraped articles.
  class IndicoTag < BaseTagger
    # This initializes the API Key for the Indico gem and verifies if its
    # present or not
    def initialize
      super
      @api_key = Thedigest::INDICO_API_KEY
      fail 'no API key' if @api_key == ''
    end

    # This method is used to generate the keywords and Indicotags using the
    # Indico gem. After the generation of tags, they are added to an array and
    # returned for further processing. We have performed exception handling to
    # ensure that the errors generated from the usage of the Indico gem are
    # handled appropriately without breaking the appliation.
    def create_tags(article)
      tags_arr = []
      Indico.api_key = @api_key
      ind_keywords = Indico.keywords article
      ind_keywords.each { |k, _v| tags_arr.push(k) }
      ind_tags = Indico.text_tags article
      ind_tags_sorted = ind_tags.sort_by { |_k, v| -1.0 * v }.first(10).to_h
      ind_tags_sorted.each { |k, _v| tags_arr.push(k) }
      puts "Indico tags:#{tags_arr}"
      tags_arr
    rescue
      Rails.logger.error { 'Tagging error in Indico' }
    end
  end
end
