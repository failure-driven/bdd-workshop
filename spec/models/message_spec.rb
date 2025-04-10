require "rails_helper"

RSpec.describe Message, type: :model do
  it "is valid" do
    message = Message.new(
      body: "the body",
      name: "the name"
    )
    expect(message).to be_valid
  end
end
