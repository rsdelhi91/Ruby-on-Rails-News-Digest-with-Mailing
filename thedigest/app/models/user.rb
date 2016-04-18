# User model validates the presence of some essential fields when user signing
# up and editing their profile. Apart from that, it also validates the format
# of user input.
# User has_secure_password and act_as_taggable_on
# Provides authenticate method when user log in
class User < ActiveRecord::Base
  # Validations
  validates_presence_of :firstname, :lastname, :username, :password
  validates_presence_of :email, if: proc { |u| u.isSubscribed == true }
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    on: :update, message: '%{value} is not a valid email' }
  validates :username, length: { minimum: 3 }
  validates :firstname, format: { with: /[A-z]+/, on: :create,
                                  message: '%{value} is not \
                                  a valid first name' }
  validates :lastname, format: { with: /[A-z]+/, on: :create,
                                 message: '%{value} is not a valid last name' }
  validates :password, length: { minimum: 4 }

  # enable the password
  has_secure_password
  # enable interest list to users
  acts_as_taggable_on :interests
  has_many :user_articles

  # Find a user by email, then check the username is the same
  def self.authenticate(password, username)
    user = User.find_by(username: username)

    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

  # Return the full name of our user.
  def full_name
    firstname + ' ' + lastname
  end
end
