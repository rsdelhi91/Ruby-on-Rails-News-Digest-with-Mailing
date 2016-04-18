## Article model provides methods to assign the search weight according to the
## query that user input.
class Article < ActiveRecord::Base
  validates_uniqueness_of :title, scope: [:pubDate]
  # enable the tag list on article
  acts_as_taggable
  # Config paginator
  max_paginates_per 10

  # Set all weights of articles to zero
  def self.init_weight
    Article.all.each do |a|
      a.update_attribute(:weight, 0.0)
    end
  end

  # Set all modified to false
  def self.init_modified
    Article.all.each do |a|
      a.update_attribute(:modified, false)
    end
  end

  # Set weight to articles
  def self.assign_weight(articles, score)
    articles.each do |article|
      new_score = article.weight + score
      article.update_attribute(:weight, new_score)
      article.update_attribute(:modified, true)
    end
  end

  # Check whether the article weight has been modified
  def self.check_changed
    Article.all.each do |article|
      article.update_attribute(:weight, 0.0) if article.modified == false
    end
  end

  # Sift out the substrings in the matching results
  def self.title_regex_match(articles, key)
    articles.delete_if { |a| /\b#{key}\b/.match(a.title).nil? }
    articles
  end

  def self.description_regex_match(articles, key)
    articles.delete_if { |a| /\b#{key}\b/.match(a.summary).nil? }
    articles
  end

  # Custom search algorithm
  def self.weight_search(query)
    if query
      # Initial search with clearing the weight
      Article.init_weight
      # Split the keywords
      keywords = query.split(' ')
      # Set up initial article scope as all
      article_scope = Article.all
      # Traverse keyword to assign weights
      keywords.each do |key|
        # Check tag list
        search_tag_results = article_scope.tagged_with(key, any: true).to_a
        Article.assign_weight(search_tag_results, Thedigest::TAG_WEIGHT)
        # Check title
        search_title_results = article_scope.search(title_cont: key)
                               .result.to_a
        search_title_results = Article
                               .title_regex_match(search_title_results, key)
        Article.assign_weight(search_title_results, Thedigest::TITLE_WEIGHT)
        # Check description
        search_description_results = article_scope.search(summary_cont: key)
                                     .result.to_a
        search_description_results = Article
                                     .description_regex_match(\
                                       search_description_results, key)
        Article.assign_weight(search_description_results,\
                              Thedigest::DESCRIPTION_WEIGHT)
        # Check source
        search_source_results = article_scope.search(source_cont: key).result
                                .to_a
        Article.assign_weight(search_source_results, Thedigest::SOURCE_WEIGHT)
        # Sift out the articles which weight hasn't increased, next time only
        # search with these articles with has match the previous keyword
        # Assign weight of these articles which don't have their weight
        # changed to zero and sift out
        Article.check_changed
        article_scope = article_scope.search(weight_gt: 0.0).result
        Article.init_modified
      end
    end
    article_scope.sort_by { |x| [x.weight, x.pubDate] }.reverse
  end
end
