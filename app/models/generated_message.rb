# == Schema Information
#
# Table name: generated_messages
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :integer          not null
#
# Indexes
#
#  index_generated_messages_on_message_id  (message_id)
#
# Foreign Keys
#
#  message_id  (message_id => messages.id)
#
class GeneratedMessage < ApplicationRecord
  belongs_to :message
end
