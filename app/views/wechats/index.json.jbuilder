json.array!(@wechats) do |wechat|
  json.extract! wechat, :id, :to_user_name, :from_user_name, :msg_type, :event, :event_key
  json.url wechat_url(wechat, format: :json)
end
