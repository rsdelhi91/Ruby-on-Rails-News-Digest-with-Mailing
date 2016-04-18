require 'bundler/setup'
require 'rubygems'
module Tagging
  # This class is used to generate tags using the tagging gem Opencalais. It
  # extracts two types of tags, namely: Opencalaistags and topics. We consider
  # both of them to generate relevant tags for our scraped articles.
  class OpencalaisTag < BaseTagger
    def initialize
      super
      @api_key = Thedigest::OPENCALAIS_API_KEY
      fail 'no API key' if @api_key == ''
    end

    # This method is used to generate tags using the Opencalaistags and topics
    # using the Opencalais gem. After the generation of tags, they are added
    # to an array and returned for further processing. We have performed
    # exception handling to ensure that the errors generated from the usage of
    # the Opencalais gem are handled appropriately without breaking the
    # appliation.
    def create_tags(article)
      tags_arr = []
      oc = OpenCalais::Client.new(api_key: @api_key)
      oc_response = oc.enrich article
      oc_response.tags.each { |t| tags_arr.push(t[:name]) }
      oc_response.topics.each { |t| tags_arr.push(t[:name]) }
      puts "OpenCalais tags:#{tags_arr}"
      tags_arr
    rescue Exception => e
      Rails.logger.error { 'Exceed the limit of OpenCalais API limit!' }
      Rails.logger.error { "Tagging error: #{e}" }
    end
  end
end
