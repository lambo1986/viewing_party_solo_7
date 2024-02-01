class ViewingPartiesController < ApplicationController
  def new
    @movie = MovieService.search_by_id(params[:movie_id])
    @user = User.find_by_id(params[:user_id])
    @viewing_party = ViewingParty.new
  end

  def create
    redirect_to user_path(current_user)
  end
end

private

def viewing_party_params
  params.require(:viewing_party).permit(:duration, :date, :start_time, :guest_ids)
end

def current_user
  current_user = User.find_by_id(params[:user_id])
end
