class RegistrationsController < Devise::RegistrationsController
  def create
    resource = User.new(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        resource.role = params[:user][:role]
        sign_up(resource_name, resource)
        render json: { email: resource.email, message: 'User created successfully', role: resource.role },
               status: :created
      else
        expire_data_after_sign_in!
        render json: { message: 'User created successfully. Please confirm your email address.' }, status: :created
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: { error: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
