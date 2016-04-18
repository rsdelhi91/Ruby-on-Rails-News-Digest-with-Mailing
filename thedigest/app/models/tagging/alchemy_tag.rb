require 'rubygems'
require 'bundler/setup'
module Tagging
  # This class is used to generate tags using the tagging gem alchemy. It
  # generates two types of tags, namely: Entity and Concept. We consider both
  # of them to generate relevant tags for our scraped articles.
  class AlchemyTag < BaseTagger
    # This initializes the API Key for the Alchemy gem and verifies if its
    # present or not
    def initialize
      super
      @api_key = Thedigest::ALCHEMY_API_KEY
      fail 'no API key' if @api_key == ''
    end

    # This method is used to generate the Entity and Concept tags using the
    # Alchemy gem. After the generation of tags, they are added to an array
    # and returned for further processing. We have performed exception
    # handling to ensure that the errors generated from the usage of the
    # Alchemy gem are handled appropriately without breaking the appliation.
    def create_tags(article)
      tags_arr = []
      AlchemyAPI.key = @api_key
      a_entities = AlchemyAPI::EntityExtraction.new.search(text: article)
      a_entities.each { |e| tags_arr.push(e['text']) }
      # puts 'Alchemy concepts:'
      a_concepts = AlchemyAPI::ConceptTagging.new.search(text: article)
      a_concepts.each { |c| tags_arr.push(c['text']) }
      tags_arr
    rescue Exception => e
      Rails.logger.error { "Tagging error: #{e}" }
    end
  end
end
