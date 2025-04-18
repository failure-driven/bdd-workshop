require "rails_helper"

RSpec.describe "messages/new", type: :view do
  before do
    assign(:message, Message.new(
      body: "MyText",
      name: "MyString",
    ),)
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do
      assert_select "textarea[name=?]", "message[body]"

      assert_select "input[name=?]", "message[name]"
    end
  end
end
