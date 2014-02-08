require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery: brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery: brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in username:user.username, password:"Foobar1"
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select 'iso 3', from:'rating[beer_id]'
    fill_in 'rating[score]', with:'15'

    expect{ click_button "Create Rating" }
      .to change{ Rating.count }.from(0).to 1

    expect(user.ratings.count).to eq 1
    expect(beer1.ratings.count).to eq 1
    expect(beer1.average_rating).to eq 15
  end

  it "rating page shows all ratings" do
    [10, 10, 20, 50, 3].each do |r|
      beer1.ratings << FactoryGirl.create(:rating, score: r, user: user)
    end
    [5, 10, 2, 1, 3].each do |r|
      beer2.ratings << FactoryGirl.create(:rating, score: r, user: user)
    end

    visit ratings_path

    [10, 10, 20, 50, 3].each do |r|
      expect(page).to have_content "iso 3 was rated a #{r}/50"
    end

    [5, 10, 2, 1, 3].each do |r|
      expect(page).to have_content "Karhu was rated a #{r}/50"
    end
  end
end