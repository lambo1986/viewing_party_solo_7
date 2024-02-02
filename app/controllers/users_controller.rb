class UsersController < ApplicationController

   def new
      @user = User.new
   end

   def show
      @user = User.find(params[:id])
      @viewing_parties_hosted = @user.hosted_viewing_parties
      @viewing_parties_unhosted = @user.viewing_parties_attended
   end

   def movies
      @user = User.find(params[:id])
      if params[:q] == "top rated"
         @top_rated = MovieService.top_rated
      elsif params[:q] == "search"
         @movie = MovieService.search(params[:search])
      end
   end

   def create
      user = User.new(user_params)
      if user.save
         flash[:success] = 'Successfully Created New User'
         redirect_to user_path(user)
      else
         flash[:error] = "#{error_message(user.errors)}"
         redirect_to register_user_path
      end
   end

private

   def user_params
      params.require(:user).permit(:name, :email)
   end
end
