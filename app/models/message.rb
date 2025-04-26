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
class Message < ApplicationRecord
  has_one :generated_message, dependent: :destroy

  # LAB 01.4
  # ========
  # This is the Model responsbile for the validation of mandatory fields, in
  # this case the presence of body and name.
  #
  # HINT:
  #   - https://guides.rubyonrails.org/active_record_validations.html
  #
  # STEPS:
  #   1. add validation to the model for mandaotory presence of body and name
  #   2. re-run the model spec
  #      `bin/rspec spec/model/message_spec.rb`
  #   3. repeat steps 1. and 2. above until the model unit spec passes

  validates :body, presence: true, allow_blank: false
  validates :name, presence: true, allow_blank: false

  def display_body
    generated_message&.body || body
  end
end
