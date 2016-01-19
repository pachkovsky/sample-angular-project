class Api::EntriesController < Api::BaseController
  def index
    render json: entries_scope
  end

  def create
    entry = entries_scope.new(entry_params)

    if entry.save
      render json: entry, status: :created
    else
      render json: {errors: entry.errors}, status: :unprocessable_entity
    end
  end

  def update
    entry = entries_scope.find(params.require(:id))

    if entry.update_attributes(entry_params)
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
      Entry.where(user_id: current_user.managed_user_ids)
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
