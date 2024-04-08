class SessionsController < Devise::SessionsController
  before_action :authenticate_user!, only: [:destroy]
  before_action :verify_signed_out_user, only: [:destroy]

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: { email: resource.email, authentication_token: resource.authentication_token, role: resource.role,
                   message: 'User successfully signed in' }
  end

  def destroy
    current_user.update(authentication_token: nil)
    sign_out(current_user)
    render json: { message: 'Logged out successfully' }
  end

  private

  def verify_signed_out_user
    return if current_user.present?

    render json: { error: 'User not signed in' }, status: :unprocessable_entity
  end
end
