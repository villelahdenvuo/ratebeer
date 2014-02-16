require 'spec_helper'

describe "styles/new" do
  before(:each) do
    assign(:style, stub_model(Style,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new style form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", styles_path, "post" do
      assert_select "input#style_name[name=?]", "style[name]"
      assert_select "textarea#style_description[name=?]", "style[description]"
    end
  end
end
