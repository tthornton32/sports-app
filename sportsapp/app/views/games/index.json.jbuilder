json.array!(@games) do |game|
  json.extract! game, :id, :latitude, :longitude, :address, :description, :title, :time, :skill_level
  json.url game_url(game, format: :json)
end
