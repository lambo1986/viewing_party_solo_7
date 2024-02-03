require 'rails_helper'

RSpec.describe Movie do
  before :each do
    @movie_data = {
      "id" => 1,
      "title" => "Inception",
      "runtime" => 148,
      "overview" => "A thief who steals corporate secrets through the use of dream-sharing technology...",
      "release_date" => "2010-07-16",
      "vote_average" => 8.3,
      "vote_count" => 29000
    }
    @movie = Movie.new(@movie_data)
  end

  it 'exists' do
    expect(@movie).to be_an_instance_of(Movie)
  end

  it 'has attributes' do
    expect(@movie.id).to eq(1)
    expect(@movie.title).to eq("Inception")
    expect(@movie.runtime).to eq(148)
    expect(@movie.overview).to eq("A thief who steals corporate secrets through the use of dream-sharing technology...")
    expect(@movie.release_date).to eq("2010-07-16")
    expect(@movie.vote_average).to eq(8.3)
    expect(@movie.vote_count).to eq(29000)
  end

  it 'has a #formatted_runtime method' do
    expect(@movie.formatted_runtime).to eq("2hr 28min")
  end
end
