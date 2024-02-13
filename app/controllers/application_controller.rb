class ApplicationController < ActionController::Base
   helper_method :current_user

   def current_user
      @_current_user ||= User.find(session[:user_id]) if session[:user_id]#only queries DB (right side of operation) if variable is nil or false
   end

   def logged_in?
      current_user.present?
   end
   
   private

   def error_message(errors)
      errors.full_messages.join(', ')
   end
end
