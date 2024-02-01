class ViewingPartiesController < ApplicationController
  def new
    @movie = MovieService.search_by_id(params[:movie_id])
    @user = User.find_by_id(params[:user_id])
    @viewing_party = ViewingParty.new
  end
end
