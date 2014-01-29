class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.find_by username: params[:username]
      if not user.nil?
        session[:user_id] = user.id
        redirect_to user
      else
        flash[:notice] = "Login failed!"
        redirect_to :back
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to :root
    end
end