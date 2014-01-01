json.array!(@market_todo_items) do |market_todo_item|
  json.extract! market_todo_item, :id, :site_id, :parent_id, :title, :description, :priority, :status, :assigned_to, :started_at, :finished_at
  json.url market_todo_item_url(market_todo_item, format: :json)
end
