class Movie

  attr_reader :id,
              :title,
              :runtime,
              :overview,
              :release_date,
              :vote_average,
              :vote_count

  def initialize(movie_data)
    @id = movie_data["id"]
    @title = movie_data["title"]
    @runtime = movie_data["runtime"]
    @overview = movie_data["overview"]
    @release_date = movie_data["release_date"]
    @vote_average = movie_data["vote_average"]
    @vote_count = movie_data["vote_count"]
  end

  def formatted_runtime
    hours = @runtime / 60
    minutes = @runtime % 60
    "#{hours}hr #{minutes}min"
  end
end
