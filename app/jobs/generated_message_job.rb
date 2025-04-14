class GeneratedMessageJob < ApplicationJob
  queue_as :default

  def perform(generated_message)
    generated_text = AITextGenerator.generate_text(generated_message.message.body)
    generated_message.update!(body: generated_text)
  end
end
