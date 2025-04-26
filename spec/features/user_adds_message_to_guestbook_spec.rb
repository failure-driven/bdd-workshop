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

      # LAB 01.1
      # ========
      # We add a new **Then** block with an assertion demonstrating the error
      # message we expect. Also a new **When** to correct the input data which
      # will continue the spec down the happy path as before.
      #
      # The pending statement, expects this feature spec to fail until it is
      # implemented, at which point it should be removed.
      #
      # MORE INFO:
      #   - https://rspec.info/features/3-12/rspec-core/pending-and-skipped-examples/pending-examples/
      #
      # STEPS:
      #   1. Uncomment the following code
      #   2. Run the spec - see 1 pending spec
      #      `bin/rspec spec/features/user_adds_message_to_guestbook_spec.rb`

      # Then "an error message is shown" do
      #   pending "validation on name and text existing"
      #   expect(guestbook.form_error.map { _1.item.text }).to eq(["Name can't be blank"])
      # end

      # When "the User submits the form with the body AND name" do
      #   guestbook.submit!(
      #     name: "Positive Patricia",
      #   )
      # end

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
