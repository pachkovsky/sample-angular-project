class Api::RegistrationsController < Api::BaseController
  skip_before_filter :authenticate_user!

  def create
    user = User.create(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: {errors: user.errors, code: 422}, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.fetch(:registration, {}).permit(:email, :password, :password_confirmation)
  end
end
