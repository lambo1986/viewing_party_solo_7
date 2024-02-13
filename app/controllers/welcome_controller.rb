class WelcomeController < ApplicationController
  def index
    @users = User.all
    unless cookies.encrypted[:greeting]
      cookies.encrypted[:greeting] = 'Howdy!'
    end
  end
end
