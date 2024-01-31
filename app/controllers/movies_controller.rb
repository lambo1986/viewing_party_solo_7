class MoviesController < ApplicationController
  def show
    @movie = MovieService.search_by_id(params[:id])
    @user = User.find(params[:user_id])
  end
end
