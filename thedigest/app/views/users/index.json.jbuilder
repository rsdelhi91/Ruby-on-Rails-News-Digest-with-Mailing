json.array!(@users) do |user|
  json.extract! user, :id, :firstname, :lastname, :username, :email, :bio, :isSubscribed, :tsOld, :tsRecent
  json.url user_url(user, format: :json)
end
