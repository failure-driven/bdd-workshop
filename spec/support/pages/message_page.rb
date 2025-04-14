# frozen_string_literal: true

module Pages
  class MessagePage < SitePrism::Page
    set_url Rails.application.routes.url_helpers.messages_path

    include Helpers::FormsHelper[
      Rails.application.routes.url_helpers.messages_path,
      Message.name.downcase
    ]

    element :new_message, "a", text: "New message"
    element :edit_message, "a", text: "Edit this message"
    element :view_messages, "a", text: "Back to messages"
    element :destroy_message, "button[type=submit]", text: "Destroy this message"
    element :generate_ai_body, "a[data-testid=generate-ai-body]"
    element :update_generated_message, "[data-testid=update-generated-message]"

    element :body, "[id^=message_] p[data-testid=body]"
    element :name, "[id^=message_] p[data-testid=name]"

    element :generated_ai_body, "[data-testid=generated-ai-body]"
    element :refresh, "[data-testid=refresh]"

    sections :form_error, "[data-testid=form-error]" do
      element :item, "li"
    end

    sections :messages, "div#messages div[id^=message_]" do
      element :body, "p[data-testid=body]"
      element :name, "p[data-testid=name]"
    end

    sections :messages_list, "[data-testid|=message]" do
      element :view, "a[data-testid=view]"
    end

    def notification
      # NOTE: rails success message is
      #   <p style=\"color: green\">Blog was successfully created.</p>
      # Presumably failure message is
      #   <p style=\"color: red\">Unprocessable operation.</p>
      find_all("p").first.text
    end

    def messages_text
      messages.map { _1.body.text }
    end

    def show_message!(number)
      page.find_all("a", text: "Show this message")[number - 1].click
    end
  end
end
