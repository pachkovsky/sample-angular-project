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
      if current_user.manager?
        current_user.managed_users << @user
        current_user.save
      end
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
      User.and(:id.in => current_user.managed_user_ids)
    end
  end

  def user_params
    if current_user.admin?
      params.fetch(:user, {}).permit(:email, :password, :role, :password_confirmation, :preferred_working_hours_per_day, managed_user_ids: [])
    elsif current_user.manager?
      params.fetch(:user, {}).permit(:email, :password, :password_confirmation, :preferred_working_hours_per_day)
    end
  end

  def authorize_user!
    if current_user.regular?
      render json: nil, status: :forbidden
    end
  end
end