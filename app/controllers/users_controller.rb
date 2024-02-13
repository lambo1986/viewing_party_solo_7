class UsersController < ApplicationController

   def new
      @user = User.new
   end

   def show
      @user = User.find(params[:id])
      @viewing_parties_hosted = @user.hosted_viewing_parties#US-7
      @viewing_parties_unhosted = @user.viewing_parties_attended#US-7
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

   def login_form

   end

   def login_user
      @user = User.find_by(email: params[:email])
      if @user && authenticate?
         flash[:success] = "Hello, #{@user.name}!"
         redirect_to user_path(@user)
      else
         flash[:error] = "Invalid Username or Password"
         render :login_form
      end
   end

   private

   def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end

   def authenticate?
      @user.authenticate(params[:password])
   end
end
