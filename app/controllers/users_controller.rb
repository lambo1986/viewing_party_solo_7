class UsersController < ApplicationController

   def new
      @user = User.new
   end

   def show
      if logged_in?
         @user = User.find(params[:id])
         @viewing_parties_hosted = @user.hosted_viewing_parties#US-7
         @viewing_parties_unhosted = @user.viewing_parties_attended#US-7
      else
         flash[:message] = "Must be logged in to access this page."
         redirect_to root_path
      end
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
      session[:user_id] = user.id
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
         session[:user_id] = @user.id
         flash[:success] = "Hello, #{@user.name}!"
         cookies.signed[:location] = params[:location]
         redirect_path = if @user.admin?
                           admin_dashboard_path
                        elsif @user.manager?
                           root_path
                        else
                           user_path(@user)#original redirect
                        end
         redirect_to redirect_path and return
      else
         flash[:error] = "Invalid Username or Password"
         render :login_form
      end
   end

   def logout_user
      session.delete(:user_id)
      flash[:success] = "You have successfully logged out."
      redirect_to root_path
   end

   private

   def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :location)
   end

   def authenticate?
      @user.authenticate(params[:password])
   end
end
