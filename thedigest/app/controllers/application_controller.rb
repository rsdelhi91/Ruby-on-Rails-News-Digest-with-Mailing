# Include SessionsHelper
# if the use is not unauthorized, redirect to error page
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Include our session helper
  include SessionsHelper
  include EmailFormatterHelper

  def authenticate_user
    render status: :unauthorized, text: '401/unauthorized' unless current_user
  end
end
