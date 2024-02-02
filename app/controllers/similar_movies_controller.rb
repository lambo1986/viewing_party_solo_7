class SimilarMoviesController < ApplicationController
  def index
    @movie = MovieService.search_by_id(params[:movie_id])
    @similar_movies = MovieService.similar(params[:movie_id])
  end
end
