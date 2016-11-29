json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :created_at, :user_id
  json.extract! post.user, :first_name, :last_name
  json.url post_url(post, format: :json)
end
