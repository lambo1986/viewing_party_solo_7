class MovieService
  API_KEY = Rails.application.credentials.tmdb[:api_key]# constant

  def self.top_rated
    conn = Faraday.new(url: "https://api.themoviedb.org")
    response = conn.get("/3/movie/top_rated?api_key=#{API_KEY}")
    data = JSON.parse(response.body, symbolize_names: true)
    movies = data[:results]
  end

  def self.search(title)
    conn = Faraday.new("https://api.themoviedb.org")
    response = conn.get("/3/search/movie?query=#{title}&api_key=#{API_KEY}")
    data = JSON.parse(response.body, symbolize_names: true)
    movie = data[:results].detect { |film| film[:original_title] == title }
  end
end
