json.extract! @post, :id, :title, :body, :created_at, :user_id
json.extract! @post.user, :first_name, :last_name