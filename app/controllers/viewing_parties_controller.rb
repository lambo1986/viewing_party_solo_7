class ViewingPartiesController < ApplicationController

  def new
    @movie = current_movie
    @user = current_user_vpc# changed this because it was named the same as the application_controller method
    if logged_in?# added this line for authentication challenge US7
      @viewing_party = ViewingParty.new
    else
      flash[:message] = "Must be logged in to create viewing party."
      redirect_to user_movie_path(params[:user_id], params[:movie_id])
    end
  end

  def create
    @user = current_user
    @movie = current_movie                                                   #needed to take the movie_id to US-7
    @viewing_party = ViewingParty.new(viewing_party_params.except(:guest_ids).merge(movie_id: params[:movie_id]))# guest_ids not needed for this, but needed for adding guests to viewing_party
    @viewing_party.movie_runtime = @movie[:runtime]# 104 is movie duration (and 135 is the party duration of the party)

    if @viewing_party.save && (@viewing_party.movie_runtime.to_i <= @viewing_party.duration.to_i)# hope this is enough
      UserParty.create!(user_id: @user.id, viewing_party_id: @viewing_party.id, host: true, movie: @movie[:id])# sets the current user as host
      @viewing_party.users << party_guests# adds the guests to the viewing party
      redirect_to user_path(current_user), notice: 'Viewing party was successfully created.'
    else
      redirect_to "/users/#{@user.id}/movies/#{@movie[:id]}/viewing_party/new", alert: 'party duration must be greater than movie duration'
    end
  end

  def show
    @movie = current_movie
    @buy_logos = MovieService.providers_buy(@movie[:id])
    @rent_logos = MovieService.providers_rent(@movie[:id])
  end

  private

  def viewing_party_params
    params.require(:viewing_party).permit(:duration, :date, :start_time, :movie_id, guest_ids: [])
  end

  def current_user_vpc
    User.find_by_id(params[:user_id])
  end

  def current_movie
    MovieService.search_by_id(params[:movie_id])
  end

  def party_guests
    User.where(id: params[:viewing_party][:guest_ids].reject(&:blank?))# nested ids, and skip the blank ones
  end
end
