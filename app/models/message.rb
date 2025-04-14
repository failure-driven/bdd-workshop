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

  def display_body
    generated_message&.body || body
  end
end
