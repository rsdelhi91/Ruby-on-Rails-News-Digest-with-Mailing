# model class which stores the user received articles
# and filter out the duplicated articles
class UserArticle < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :article_id, scope: [:user_id]
end
