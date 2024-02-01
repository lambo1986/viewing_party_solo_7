class Movies# brainstorming
  attr_reader :id, :title, :runtime

  def initialize(movie_data)
    @id = movie_data["id"]
    @title = movie_data["title"]
    @runtime = movie_data["runtime"]
  end
end
