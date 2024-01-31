class MovieService
  API_KEY = Rails.application.credentials.tmdb[:api_key]# constant (upcase means this variable should not change)

  def self.top_rated
    conn = Faraday.new(url: "https://api.themoviedb.org")
    response = conn.get("/3/movie/top_rated?api_key=#{API_KEY}")
    data = JSON.parse(response.body, symbolize_names: true)
    movies = data[:results]
  end

  def self.search(title)
    conn = Faraday.new("https://api.themoviedb.org")
    response = conn.get("/3/search/movie") do |req|# input movie title and user key
      req.params['api_key'] = API_KEY
      req.params['query'] = title
    end
    data = JSON.parse(response.body, symbolize_names: true)
    data[:results].detect { |film| film[:title].strip.casecmp(title.strip).zero? }#rid the whitespace and ignore case
  end

  def self.search_by_id(id)
    conn = Faraday.new("https://api.themoviedb.org")
    response = conn.get("/3/movie/#{id}") do |req|# input movie id and user key
      req.params['api_key'] = API_KEY
      req.params['query'] = id
    end
    data = JSON.parse(response.body, symbolize_names: true)
  end

  def self.genres_all# US-3
    conn = Faraday.new("https://api.themoviedb.org")
    response = conn.get("/3/genre/movie/list") do |req|# input movie id and user key
      req.params['api_key'] = API_KEY
    end
    data = JSON.parse(response.body, symbolize_names: true)
    data[:genres]
  end

  def self.genres_of_movie(movie_id)#US-3
    movie = search_by_id(movie_id)
    movie[:genres].map { |genre| genre[:name] }
  end

  def self.runtime(movie_id)# US-3
    movie = search_by_id(movie_id)
    format_runtime(movie[:runtime])
  end

  def self.cast(movie_id)# US-3
    conn = Faraday.new("https://api.themoviedb.org")
    response = conn.get("/3/movie/#{movie_id}/credits") do |req|# input movie id
      req.params['api_key'] = API_KEY
    end
    data = JSON.parse(response.body, symbolize_names: true)
    data[:cast].take(10)
  end

  def self.reviews(movie_id)# US-3
    conn = Faraday.new("https://api.themoviedb.org")
    response = conn.get("/3/movie/#{movie_id}/reviews") do |req|# input movie id and user key
      req.params['api_key'] = API_KEY
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end

private

def format_runtime(minutes)# US-3 (move to facade or PORO)
  hours = minutes / 60
  remainder = minutes % 60
  "#{hours}hr #{remainder}min"
end
