class Api::ExportsController < Api::BaseController
  def index
    scope = entries_scope
    scope = scope.gte(date: params[:from]) if params[:from].present?
    scope = scope.lte(date: params[:to]) if params[:to].present?
    @entries = scope.order(:created_at.desc).all.group_by(&:date).sort.map{ |date, entries| [date, entries.group_by(&:user_id)] }
    render layout: false
  end

  protected
  def session_token
    params.require(:token)
  end

  private
  def entries_scope
    if current_user.admin?
      Entry.all
    elsif current_user.manager?
      Entry.in(user_id: [current_user.id, *current_user.managed_user_ids])
    else
      current_user.entries.all
    end
  end
end
