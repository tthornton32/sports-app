class HomeController < ApplicationController
def index
      @games = Game.all
    @hash = Gmaps4rails.build_markers(@games) do |game, marker|
      marker.lat game.latitude
      marker.lng game.longitude
      marker.infowindow render_to_string(:partial => "layouts/window", :locals => { :object => game})
    end
  end
end