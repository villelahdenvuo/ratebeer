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
		let(:user){ FactoryGirl.create(:user) }

		it "is saved" do
			expect(user).to be_valid
			expect(User.count).to eq 1
		end

		it "and two ratings, has the correct average rating" do
			user.ratings << FactoryGirl.create(:rating)
			user.ratings << FactoryGirl.create(:rating2)

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

	describe "favorite beer" do
		let(:user){FactoryGirl.create(:user) }

		it "has method for determining one" do
			user.should respond_to :favorite_beer
		end

		it "without ratings does not have one" do
			expect(user.favorite_beer).to eq nil
		end

		it "is the only rated if only one rating" do
      beer = FactoryGirl.create :beer
      rating = FactoryGirl.create :rating, beer:beer, user:user

      expect(user.favorite_beer).to eq beer
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings 10, 20, 15, 7, 9, user
      best = create_beer_with_rating 25, user

      expect(user.favorite_beer).to eq best
    end
	end

	describe "favorite style" do
		let(:user){ FactoryGirl.create(:user) }

		it "has method for determining one" do
			user.should respond_to :favorite_style
		end

		it "without ratings does not have one" do
			expect(user.favorite_style).to eq nil
		end

		it "is the only rated if only one rating" do
			create_beer_with_rating_and_style "Lager", 20, user

      expect(user.favorite_style).to eq "Lager"
    end

    it "is the one with highest average rating" do
      create_beer_with_rating_and_style "Lager", 10, user
      create_beer_with_rating_and_style "Lager", 35, user
      create_beer_with_rating_and_style "Porter", 20, user

      expect(user.favorite_style).to eq "Lager"

      create_beer_with_rating_and_style "Porter", 50, user

      expect(user.favorite_style).to eq "Porter"
    end
	end
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create :beer
  FactoryGirl.create :rating, score:score, beer:beer, user:user
  beer
end

def create_beer_with_rating_and_style(style, score, user)
  beer = FactoryGirl.create :beer, style: style
  FactoryGirl.create :rating, score:score, beer:beer, user:user
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end