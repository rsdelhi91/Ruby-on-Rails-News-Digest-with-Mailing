require 'json'
require 'net/http'

module Importers
  # This class scrapes the data from the RSS feed: Guardian based
  # on the link
  class GuardianImporter < BaseImporter
    # This is used to call the superclass to validate the methods being
    # implemented.
    def initialize
      super
    end

    # RETURN THE SOURCE NAME
    def self.source_name
      'Guardian'
    end

    # This method scrapes the data from the JSON feed for The Guardian and
    # passes it into the articles table in the database, having attributes
    # which are accessible via the data scraped.
    def scrape
      @articles = []
      url = 'http://content.guardianapis.com/'
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      path = '/search?api-key=26ev58nurfts4nvmt75w7wwh&show-fields=all'
      response = http.send_request('GET', path)
      json_data = JSON.parse(response.body)
      article_list = json_data['response']['results']
      re = /<("[^"]*"|'[^']*'|[^'">])*>/
      sanitizer = Rails::Html::FullSanitizer.new
      article_list.each do |item|
        a_title = item['webTitle']
        a_summary = item['fields']['body']
        # a_summary.gsub!(re, '')
        a_summary = sanitizer.sanitize(a_summary)
        a_source = GuardianImporter.source_name
        a_link = item['webUrl']
        a_date = DateTime.parse(item['webPublicationDate'])
        a_author = item['fields']['byline']
        a_images = item['fields']['thumbnail']
        article = Article.create(title: a_title, summary: a_summary,
                                 source: a_source, pubDate: a_date,
                                 imageURL: a_images, author: a_author,
                                 link: a_link)
        @articles << article
      end
      @articles
    end
  end
end
