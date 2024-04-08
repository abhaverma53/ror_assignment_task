module ApiCallLogger
  extend ActiveSupport::Concern

  included do
    before_action :log_api_call
  end

  private

  def log_api_call
    token = extract_token_from_headers
    user = User.find_by(authentication_token: token)
    PlatformApiCall.create(
      requested_url: request.url,
      requested_data: request.request_parameters.to_json,
      response_data: response.body,
      user_id: user&.id
    )
  end

  def extract_token_from_headers
    token = request.headers['Authorization']&.split(' ')&.last
    token || params[:authentication_token]
  end
end
