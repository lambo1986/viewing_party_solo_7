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
end
