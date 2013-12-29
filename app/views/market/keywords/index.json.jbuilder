json.array!(@market_keywords) do |market_keyword|
  json.extract! market_keyword, :id, :market_site_id, :parent_id, :name
  json.url market_keyword_url(market_keyword, format: :json)
end
