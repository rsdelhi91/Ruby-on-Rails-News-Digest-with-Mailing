# This module registers all the tagging methods available in the tagging
# folder and generates tags for the scraped articles passed into this module.
module Tagging
  # This method is used to register all the tagging methods available in the
  # tagging folder. It instantiates it and passes it into an array for use in
  # the tag_all method
  def all_tags
    tag1 = Tagging::AlchemyTag.new
    tag2 = Tagging::IndicoTag.new
    tag3 = Tagging::OpencalaisTag.new
    tag4 = Tagging::SentimentalTag.new
    tag5 = Tagging::CustomTag.new
    tag6 = Tagging::HighscoreTag.new
    [tag1, tag2, tag3, tag4, tag5, tag6]
  end

  # This method is used to iterate over each tagging method available and
  # generate relevant tags for the articles passed to this method.
  def tag_all(article)
    unless article.nil?
      # define an overall tag array
      tags = []
      taggings ||= all_tags
      taggings.each do |tag|
        # Pass all tags in an array and flatten them
        article_info = article.title.to_s + ' ' + article.summary.to_s
        (tags << tag.create_tags(article_info)).flatten!
      end
    end
    puts "TAGS: #{tags}"
    # return a unique set of tags ensuring no repeat tags.
    tags.uniq
  end
end
