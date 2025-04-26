# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Message, type: :model do
  it "is valid" do
    message = Message.new(
      body: "the body",
      name: "the name",
    )
    expect(message).to be_valid
  end

  # LAB 01.3
  # ========
  # This is the Unit tests where we need to add a test for body and name being
  # empty will make the model Message invalid.
  #
  # HINT:
  #   - https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
  #   - `expect(message).not_to be_valid`
  #
  # STEPS:
  #   1. write some specs to demonstrate a Message with empty body and name are invalid
  #   2. run the test - see failing tests
  #      `bin/rspec spec/model/message_spec.rb`

  # it "is invalid with no body" do
  #   message = Message.new(
  #     body: "",
  #     name: "the name",
  #   )
  #   expect(message).not_to be_valid
  # end

  # it "is invalid with no name" do
  #   message = Message.new(
  #     body: "the body",
  #     name: "",
  #   )
  #   expect(message).not_to be_valid
  # end
end
