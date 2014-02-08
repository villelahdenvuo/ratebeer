require 'spec_helper'

describe Beer do
  it 'is saved with name and style' do
  	beer = Beer.create name:"Testiolut", style:"Laageri"
    expect(beer).to be_valid
    expect(Beer.count).to eq 1
  end
  it 'is not saved without a name' do
  	beer = Beer.create style:"Laageri"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq 0
  end
  it 'is not saved without a style' do
  	beer = Beer.create name:"Testiolut"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq 0
  end
end
