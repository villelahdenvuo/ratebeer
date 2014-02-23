require 'spec_helper'

describe "Breweries page" do
  describe "when breweries exists" do
    before :each do
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
      end

      visit breweries_path
    end

    it "lists the breweries and their total number" do
      @breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
    end

    it "allows user to navigate to page of a Brewery" do
      click_link "Koff"

      expect(page).to have_content "Koff"
      expect(page).to have_content "Established at 1897"
    end

  end
end