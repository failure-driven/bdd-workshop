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

      Then "an error message is shown" do
        expect(guestbook.form_error.map { _1.item.text }).to eq(["Name can't be blank"])
      end

      When "the User submits the form with the body AND name" do
        guestbook.submit!(
          name: "Positive Patricia",
        )
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

    # LAB 02.1
    # ========
    # The existing happy path of creating a manual message for the guestbook
    # should just work. Here we create a new scenario where the user can
    # optinoally choose to have AI augment their message and select if they like
    # the new message. The below spec will fail as it cannot find the generate
    # AI button which will take us to LAB 02.2 .
    #
    # STEPS:
    #   1. Uncomment the following code
    #   2. Run the spec - see 1 pending spec `bin/rspec
    #      spec/features/user_adds_message_to_guestbook_spec.rb`

    # scenario "User adds message to the guestbook with AI generated body" do
    #   When "a new entry is added to the guestbook" do
    #     guestbook.load
    #     guestbook.new_message.click
    #     guestbook.submit!(
    #       body: "Finally understood the benefits fo testing first",
    #       name: "Positive Patricia",
    #     )
    #   end

    #   Then "the visitor is told the message is successfully created" do
    #     binding.irb if ENV.fetch("SPEC_PAUSE", false) # rubocop:disable Lint/Debugger
    #     expect(guestbook.notification).to eq "Message was successfully created."
    #   end

    #   When "the user views the message and clicks generate AI text" do
    #     guestbook.messages_list.last.view.click
    #     pending "a generate AI body button existing"
    #     binding.irb if ENV.fetch("SPEC_PAUSE", false) # rubocop:disable Lint/Debugger
    #     guestbook.generate_ai_body.click
    #   end

    #   Then "the generated AI text is displayed" do
    #     binding.irb if ENV.fetch("SPEC_PAUSE", false) # rubocop:disable Lint/Debugger
    #     SitePrism::Waiter.wait_until_true {
    #       expect(page).to have_content "AI text successfully generated."
    #     }
    #     expect(guestbook.notification).to eq "AI text successfully generated."
    #     expect(
    #       guestbook.generated_ai_body,
    #     ).to have_text "AI GENERATED Finally understood the benefits fo testing first"
    #   end

    #   When "when the user continues with the update" do
    #     guestbook.update_generated_message.click
    #   end

    #   Then "the visitor sees the message is updated" do
    #     binding.irb if ENV.fetch("SPEC_PAUSE", false) # rubocop:disable Lint/Debugger
    #     SitePrism::Waiter.wait_until_true {
    #       expect(page).to have_content "Generated message was successfully updated."
    #     }
    #     expect(guestbook.notification).to eq "Generated message was successfully updated."
    #     expect(
    #       guestbook.body,
    #     ).to have_text "AI GENERATED Finally understood the benefits fo testing first"
    #   end

    #   When "the user views all messages" do
    #     guestbook.view_messages.click
    #   end

    #   Then "the guestbook has the new message" do
    #     binding.irb if ENV.fetch("SPEC_PAUSE", false) # rubocop:disable Lint/Debugger
    #     expect(guestbook.messages_text).to include(
    #       "AI GENERATED Finally understood the benefits fo testing first",
    #     )
    #   end
    # end
  end
end
