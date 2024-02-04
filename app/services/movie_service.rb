class MovieService
  API_KEY = Rails.application.credentials.tmdb[:api_key]
  BASE_URL = "https://api.themoviedb.org"

  class << self

    def top_rated
      data = get_url("/3/movie/top_rated")
      data[:results]
    end

    def search(title)
      response = conn.get("/3/search/movie") do |req|# input movie title and user key
        req.params['api_key'] = API_KEY
        req.params['query'] = title
      end
      data = JSON.parse(response.body, symbolize_names: true)
      data[:results].detect { |film| film[:title].strip.casecmp(title.strip).zero? }#rid the whitespace and ignore case
    end

    def search_by_id(id)
      response = conn.get("/3/movie/#{id}") do |req|# input movie id and user key
        req.params['api_key'] = API_KEY
        req.params['query'] = id
      end
      data = JSON.parse(response.body, symbolize_names: true)
    end

    def genres_all# US-3
      response = conn.get("/3/genre/movie/list") do |req|# input movie id and user key
        req.params['api_key'] = API_KEY
      end
      data = JSON.parse(response.body, symbolize_names: true)
      data[:genres]
    end

    def genres_of_movie(movie_id)#US-3
      movie = search_by_id(movie_id)
      movie[:genres].map { |genre| genre[:name] }
    end

    def runtime(movie_id)# US-3
      movie = search_by_id(movie_id)
      format_runtime(movie[:runtime])
    end

    def cast(movie_id)# US-3
      response = conn.get("/3/movie/#{movie_id}/credits") do |req|# input movie id
        req.params['api_key'] = API_KEY
      end
      data = JSON.parse(response.body, symbolize_names: true)
      data[:cast].take(10)
    end

    def reviews(movie_id)# US-3
      response = conn.get("/3/movie/#{movie_id}/reviews") do |req|# input movie id and user key
        req.params['api_key'] = API_KEY
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    def providers_rent(movie_id)# US-5
      response = conn.get("/3/movie/#{movie_id}/watch/providers") do |req|
        req.params['api_key'] = API_KEY
      end
      data = JSON.parse(response.body, symbolize_names: true)
      data[:results][:US][:buy].map { |service| service[:logo_path] }
    end

    def providers_buy(movie_id)# US-5
      response = conn.get("/3/movie/#{movie_id}/watch/providers") do |req|
        req.params['api_key'] = API_KEY
      end
      data = JSON.parse(response.body, symbolize_names: true)
      data[:results][:US][:rent].map { |service| service[:logo_path] }
    end

    def similar(movie_id)# US-6
      response = conn.get("/3/movie/#{movie_id}/similar") do |req|
        req.params['api_key'] = API_KEY
      end
      data = JSON.parse(response.body, symbolize_names: true)
      data[:results]
    end

    private

    def conn
      Faraday.new(url: BASE_URL)
    end

    def get_url(path)
      response = conn.get(path) do |req|
        req.params['api_key'] = API_KEY
      end
      JSON.parse(response.body, symbolize_names: true)
    end


  end
end

private

def format_runtime(minutes)# US-3 (move to facade or PORO)
  hours = minutes / 60
  remainder = minutes % 60
  "#{hours}hr #{remainder}min"
end
