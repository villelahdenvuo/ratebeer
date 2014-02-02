class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.find_by username: params[:username]
      if not user.nil? and user.authenticate params[:password]
        session[:user_id] = user.id
        redirect_to user, notice: "Welcome back!"
      else
        redirect_to :back, notice: "Username and password do not match."
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to :root
    end
end