
require 'date'
require 'open-uri'
require 'json'
require 'net/http'
module Importers
  # This class scrapes the data from the RSS feed: New York Times based
  # on the link
  class NYTImporter < BaseImporter
    # This is used to call the superclass to validate the methods being
    # implemented. Also, this sets the API key for the JSON source.
    def initialize
      super
      @nyt_api_key = Thedigest::NYT_API_KEY
    end

    # RETURN THE SOURCE NAME
    def self.source_name
      'The New York Times'
    end

    # This method scrapes the data from the JSON feed for The New York Times
    # and passes it into the articles table in the database, having attributes
    # which are accessible via the data scraped.
    def scrape
      @articles = []
      # CODE HERE
      url = 'http://api.nytimes.com/'
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = false
      request_url = url + 'svc/search/v2/articlesearch.'\
      'json?fq=romney&facet_field=day_of_week&begin_date'\
      "=#{(Date.today - 7).to_s.delete!('-')}&end_date"\
      "=#{Date.today.to_s.delete!('-')}&api-key=#{@nyt_api_key}"
      response = http.send_request('GET', request_url)
      json_message = JSON.parse(response.body)
      json_message.fetch('response').fetch('docs').each do |key|
        article = Article.create(author: nil,
                                 title: key.fetch('headline').fetch('main')
                                 .to_s,
                                 summary: key.fetch('snippet') ? (key.fetch('abstract')) : nil,
                                 imageURL: nil,
                                 source: key.fetch('source'),
                                 pubDate: DateTime.parse(key.fetch('pub_date')
                                  .to_s),
                                 link: key.fetch('web_url').to_s)
        @articles << article
      end
      @articles
    end
  end
end
