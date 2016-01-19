class Api::SessionsController < Api::BaseController
  skip_before_filter :authenticate_user!, only: :create

  def create
    user = User.where(email: user_params[:email]).first

    if user && user.valid_password?(user_params[:password])
      render json: Session.create(user: user), status: :created
    else
      render json: nil, status: :unauthorized
    end
  end

  def destroy
    current_session.destroy
    render json: nil, status: :ok
  end

private
  def user_params
    params.fetch(:session, {}).permit(:email, :password)
  end
end
