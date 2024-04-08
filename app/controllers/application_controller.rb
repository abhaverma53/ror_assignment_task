class ApplicationController < ActionController::Base
  before_action :authenticate_user_from_token!
  protect_from_forgery
  acts_as_token_authentication_handler_for User

  private

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, _options|
      user = User.find_by(authentication_token: token)
      sign_in(user, store: false) if user
    end
  end
end
