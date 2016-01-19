class Api::ProfilesController < Api::BaseController
  def show
    @user = current_user
    render 'api/users/show'
  end

  def update
    if current_user.update_attributes(profile_params)
      render json: current_user
    else
      render json: {errors: current_user.errors}, status: :unprocessable_entity
    end
  end

  private
  def profile_params
    params.fetch(:profile, {}).permit(:preferred_working_hours_per_day)
  end
end
