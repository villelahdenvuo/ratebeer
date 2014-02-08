require 'spec_helper'
include OwnTestHelper

describe "User" do
  let!(:user) { FactoryGirl.create :user }

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in username: user.username, password:"Foobar1"

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content user.username
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in username: user.username, password:"wrong"

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and password do not match'
    end
  end

  describe "who has signed up and rated" do
    before :each do
      sign_in username:user.username, password:"Foobar1"
      beer = FactoryGirl.create :beer
      user2 = FactoryGirl.create(:user)
      user2.ratings << FactoryGirl.create(:rating, score: 50, beer: beer)
      user.ratings << FactoryGirl.create(:rating, beer: beer)
      user.ratings << FactoryGirl.create(:rating2, beer: beer)
      visit user_path(user)
    end

    it "should see all their own ratings" do
      expect(page).to have_content "anonymous was rated a 10/50"
      expect(page).to have_content "anonymous was rated a 20/50"
      expect(page).not_to have_content "anonymous was rated a 50/50"
    end

    it "should be able to delete their rating" do
      expect(page).to have_content "anonymous was rated a 10/50"
      first(:xpath, "(//a[text()='delete'])").click
      expect(page).not_to have_content "anonymous was rated a 10/50"
    end

    it "should see favorite style, beer and brewery" do
      expect(page).to have_content "favorite style is Lager, favorite beer is anonymous and favorite brewery is anonymous."
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{ click_button 'Create User' }
      .to change{ User.count }.by 1
  end
end