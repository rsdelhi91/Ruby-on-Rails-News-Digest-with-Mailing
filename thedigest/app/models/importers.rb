# This module is used to register the importers present in the importers folder
# to scrape articles, and call scrape on them to initiate the scraping process
# for articles from different sources.
module Importers
  # This method is used to register all the importers present in the importers
  # folder and return their instances as an array.
  def all_importers
    imp1 = Importers::ABCImporter.new
    imp2 = Importers::GuardianImporter.new
    imp3 = Importers::HSImporter.new
    imp4 = Importers::NYTImporter.new
    imp5 = Importers::SBSImporter.new
    imp6 = Importers::SMHImporter.new
    imp7 = Importers::THEAGEImporter.new
    [imp1, imp2, imp3, imp4, imp5, imp6, imp7]
  end

  # This method is used to iterate over each importer instance received and
  # call the
  # scrape method on them to initiate the scraping process of articles from
  # different
  # sources.
  def scrape_all
    # define an overall article array
    @articles = []
    @importers ||= all_importers
    @importers.each do |importer|
      # pass all articles in an array and flatten them
      (@articles << importer.scrape).flatten!
    end
    # DEBUGGING
    puts "Total articles number: #{@articles.count}"
    @articles
  end
end
