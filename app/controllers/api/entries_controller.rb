class Api::EntriesController < Api::BaseController
  def index
    scope = entries_scope
    scope = scope.gte(date: params[:from]) if params[:from].present?
    scope = scope.lte(date: params[:to]) if params[:to].present?
    @entries = scope.order(:date.desc).includes(:user)
  end

  def show
    @entry = entries_scope.find(params.require(:id))
  end

  def create
    entry = entries_scope.new(entry_params)

    if current_user.manager? && entry.user && ![current_user, *current_user.managed_users].include?(entry.user)
      return render json: nil, status: :forbidden
    end

    if entry.save
      render json: entry, status: :created
    else
      render json: {errors: entry.errors}, status: :unprocessable_entity
    end
  end

  def update
    entry = entries_scope.find(params.require(:id))

    entry.assign_attributes(entry_params)

    if current_user.manager? && entry.user && ![current_user, *current_user.managed_users].include?(entry.user)
      return render json: nil, status: :forbidden
    end

    if entry.save
      render json: entry
    else
      render json: {errors: entry.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    entry = entries_scope.find(params.require(:id))
    entry.destroy
    render json: nil, status: 200
  end

  private
  def entries_scope
    if current_user.admin?
      Entry.all
    elsif current_user.manager?
      Entry.and(:user_id.in => [current_user.id, *current_user.managed_user_ids])
    else
      current_user.entries.all
    end
  end

  def entry_params
    if current_user.admin? || current_user.manager?
      params.fetch(:entry, {}).permit(:user_id, :date, :hours, :note)
    else
      params.fetch(:entry, {}).permit(:date, :hours, :note)
    end
  end
end
