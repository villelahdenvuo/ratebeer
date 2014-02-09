require 'spec_helper'
include OwnTestHelper

describe "Beer page" do

  it "has a link to creating a new beer if user is signed in" do
    user = FactoryGirl.create :user
    sign_in username:user.username, password:"Foobar1"
    visit beers_path
    expect(page).to have_content "New Beer"
  end

  it "no link for creating if not signed in" do
    visit beers_path
    expect(page).not_to have_content "New Beer"    
  end

  describe "creating a new beer" do
    before :each do
      user = FactoryGirl.create :user
      sign_in username:user.username, password:"Foobar1"      
      FactoryGirl.create :brewery, name: "Koff"
      visit new_beer_path
      select 'Koff', from:'beer[brewery_id]'
    end

    it "creating a new beer with a valid name works" do
      fill_in 'beer_name', with: 'Olunen'

      expect{ click_button 'Create Beer' }
        .to change{ Beer.count }.by 1

      expect(current_path).to eq beers_path
    end

    it "creating a new beer with invalid name doesn't work" do
      fill_in 'beer_name', with: ''

      expect{ click_button 'Create Beer' }
        .not_to change{ Beer.count }

      expect(page).to have_content "Name can't be blank"
    end
  end
end