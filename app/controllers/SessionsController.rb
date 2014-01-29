class SessionsController < ApplicationController
    def new
    end

    def create
      # haetaan usernamea vastaava käyttäjä tietokannasta
      user = User.find_by username: params[:username]
      # talletetaan sessioon kirjautuneen käyttäjän id (jos käyttäjä on olemassa)
      session[:user_id] = user.id unless user.nil?
      # uudelleen ohjataan käyttäjä omalle sivulleen 
      redirect_to user   
    end

    def destroy
      # nollataan sessio
      session[:user_id] = nil
      # uudelleenohjataan sovellus pääsivulle 
      redirect_to :root
    end
end