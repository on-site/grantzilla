json.array!(@grants) do |grant|
  json.extract! grant, :id, :date, :details
  json.url grant_url(grant, format: :json)
end
