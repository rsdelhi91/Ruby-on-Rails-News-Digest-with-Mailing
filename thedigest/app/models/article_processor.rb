# This class is used to call the scrape_all method in the Importers module to
# initiate the scraping process, following which it will call the tag_all
# method in the Tagging module to perform the tagging process of the scraped
# articles. This ensures that the scraping and Tagging of articles are
# performed separately.
class ArticleProcessor
  include Importers
  include Tagging

  # This is used to initialize the articles array which will store all the
  # scraped article instances.
  def init
    @articles = []
  end

  # This method is used to store all the article instances coming from the
  # various importers and pass them to the Tagging module to generate tags.
  def import_article
    # scrape from all sources using the importers module
    @articles = scrape_all
    # Tag all of these articles using the tagging library
    @articles.each do |article|
      article.update_attribute(:tag_list, tag_all(article).to_a[0...9])
    end
  end
end
