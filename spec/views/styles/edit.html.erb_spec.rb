require 'spec_helper'

describe "styles/edit" do
  before(:each) do
    @style = assign(:style, stub_model(Style,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit style form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", style_path(@style), "post" do
      assert_select "input#style_name[name=?]", "style[name]"
      assert_select "textarea#style_description[name=?]", "style[description]"
    end
  end
end
