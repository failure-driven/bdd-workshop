# frozen_string_literal: true

ActiveJob::Base.queue_adapter = :test

feature "User adds message to guestbook", :js do
  include ActiveJob::TestHelper

  let(:guestbook) { Pages::MessagePage.new }

  context "when there are existing guestbook entries" do
    before do
      Message.create!(name: "Gordon Great", body: "Presentation was great!")
      Message.create!(name: "Tyrel Tryer", body: "Can't wait to try these techniques at work!")
    end

    scenario "User adds message to the guestbook" do
      When "the guestbook page is viewed" do
        guestbook.load
      end

      Then "guestbook messages are displayed" do
        expect(guestbook.messages_text).to eq(
          [
            "Presentation was great!",
            "Can't wait to try these techniques at work!",
          ],
        )
        binding.irb if ENV.fetch("SPEC_PAUSE", false) # rubocop:disable Lint/Debugger
      end

      When "the User submits the form with just the body" do
        guestbook.new_message.click
        guestbook.fill_in(
          body: "Finally understood the benefits of testing first",
        )
        binding.irb if ENV.fetch("SPEC_PAUSE", false) # rubocop:disable Lint/Debugger
        guestbook.submit!
      end

      Then "a success notification is shown" do
        guestbook.when_loaded do |page|
          expect(page.notification).to eq "Message was successfully created."
        end
        binding.irb if ENV.fetch("SPEC_PAUSE", false) # rubocop:disable Lint/Debugger
      end

      And "the guestbook has the new message" do
        expect(guestbook).to have_messages(count: 3)
        expect(guestbook.messages_text).to include(
          "Finally understood the benefits of testing first",
        )
      end
    end
  end
end
