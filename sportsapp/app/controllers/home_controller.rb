class HomeController < ApplicationController
def index
    @games = Game.all
    @hash = Gmaps4rails.build_markers(@games) do |game, marker|
      marker.lat game.latitude
      marker.lng game.longitude
      
    end
  end
end