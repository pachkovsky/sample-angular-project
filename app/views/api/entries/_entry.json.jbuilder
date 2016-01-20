if entry.errors.any?
  json.errors entry.errors
else
  json.extract! entry, :id, :date, :hours, :note, :created_at, :updated_at, :user_id
  json.user do
    json.extract! entry.user, :id, :email, :preferred_working_hours_per_day
  end
end
