json.array!(@market_sites) do |market_site|
  json.extract! market_site, :id, :name, :domain, :online_date
  json.url market_site_url(market_site, format: :json)
end
