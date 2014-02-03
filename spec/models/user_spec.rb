require 'spec_helper'

describe User do
  describe "with just username" do
    let(:user){ User.create username:"Pekka" }

    it "has it set correctly" do
      expect(user.username).to eq "Pekka"
    end

    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq 0
    end  
  end

  describe "with a proper password" do
    let(:user){ User.create username:"Pekka",
                            password:"Secret1",
                            password_confirmation:"Secret1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq 1
    end  

    it "and two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq 2
      expect(user.average_rating).to eq 15
    end  
  end

  describe "with a shitty password" do
    def check_password password
      user = User.create username:"Pekka",
                          password: password,
                          password_confirmation: password      
      expect(user).not_to be_valid
      expect(User.count).to eq 0
    end

    it("with no number is not saved") { check_password "Secret" }
    it("with no caps is not saved") { check_password "secret1" }
    it("that is too short is not saved") { check_password "L1" }
  end  
end