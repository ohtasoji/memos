json.extract! comment, :id, :sentence, :user_id, :memo_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)