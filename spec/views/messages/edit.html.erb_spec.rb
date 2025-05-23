require "rails_helper"

RSpec.describe "messages/edit", type: :view do
  let(:message) {
    Message.create!(
      body: "MyText",
      name: "MyString",
    )
  }

  before do
    assign(:message, message)
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(message), "post" do
      assert_select "textarea[name=?]", "message[body]"

      assert_select "input[name=?]", "message[name]"
    end
  end
end
