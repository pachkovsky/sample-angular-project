class Api::UsersController < Api::BaseController
  before_filter :authorize_user!

  def index
    @users = users_scope.all
  end

  def show
    @user = users_scope.find(params.require(:id))
  end

  def create
    @user = users_scope.new(user_params)

    if @user.save
      render :show, status: :created
    else
      render :show, status: :unprocessable_entity
    end
  end

  def update
    @user = users_scope.find(params.require(:id))

    if @user.update_attributes(user_params)
      render :show
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    user = users_scope.find(params.require(:id))
    user.destroy
    render json: nil
  end

  private
  def users_scope
    if current_user.admin?
      User.all
    elsif current_user.manager?
      User.in(_id: [current_user.id, *current_user.managed_user_ids])
    end
  end

  def user_params
    if current_user.admin?
      params.fetch(:user, {}).permit(:email, :password, :password_confirmation, :managed_user_ids)
    elsif current_user.manager?
      params.fetch(:user, {}).permit(:email, :password, :password_confirmation)
    end
  end

  def authorize_user!
    if current_user.regular?
      render json: nil, status: :forbidden
    end
  end
end