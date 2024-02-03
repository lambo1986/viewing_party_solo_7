class MovieFacade
  def initialize(search_param = nil)
    @search_param = search_param
  end

  def movies
    if @search_param.present?
      search_results = MovieService.search(@search_param)
      search_results.map { |movie_data| Movie.new(movie_data) }
    else
      top_rated_movies = MovieService.top_rated
      top_rated_movies.map { |movie_data| Movie.new(movie_data) }
    end
  end
end
