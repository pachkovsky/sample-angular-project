if user.errors.any?
  json.errors user.errors
else
  json.extract! user, :id, :email, :preferred_working_hours_per_day, :created_at, :updated_at, :role
  if current_user.admin?
    json.extract! user, :managed_user_ids
  end
end
