class ViewingPartiesController < ApplicationController
  def new
    @movie = current_movie
    @user = current_user
    @viewing_party = ViewingParty.new
  end

  def create
    @user = current_user
    @viewing_party = ViewingParty.new(viewing_party_params.except(:guest_ids))

    if @viewing_party.save
      UserParty.create!(user_id: @user.id, viewing_party_id: @viewing_party.id, host: true)# sets the current user as host
      guests = User.where(id: params[:viewing_party][:guest_ids].reject(&:blank?))# nested ids, and skip the blank ones
      @viewing_party.users << guests# adds the guests to the viewing party 
      redirect_to user_path(current_user), notice: 'Viewing party was successfully created.'
    else
      render :new# test for this?
    end
  end
end

private

def viewing_party_params
  params.require(:viewing_party).permit(:duration, :date, :start_time, guest_ids: [])
end

def current_user
  User.find_by_id(params[:user_id])
end

def current_movie
  MovieService.search_by_id(params[:movie_id])
end
