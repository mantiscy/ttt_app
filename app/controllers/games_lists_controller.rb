class GamesListsController < ApplicationController

  load_and_authorize_resource

  def index
    @games = GamesList.all
  end

end
