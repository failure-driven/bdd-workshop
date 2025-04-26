class GeneratedMessagesController < ApplicationController
  before_action :set_generated_message, only: %i[edit update destroy]

  # @route GET /messages/:message_id/generated_messages/:id/edit (edit_message_generated_message)
  def edit
  end

  # @route POST /messages/:message_id/generated_messages (message_generated_messages)
  def create
    @generated_message = GeneratedMessage.find_or_create_by(generated_message_params)

    # LAB 02.3
    # ========
    # Call the AITextGenerator inline with the existing message.body
    #
    # HINT:
    #   - app/services/ai_text_generator.rb
    #   - AITextGenerator.generate_text( <body> )
    #
    # STEPS:
    #   1. update the @generated_message.body with the generated text
    #   2. also update the notification flash message below in LAB 02.4

    @generated_message.body = AITextGenerator.generate_text(
      @generated_message.message.body,
    )

    # LAB 04.2
    # ========
    # Call the generate text in background job
    #
    # HINT:
    #   - https://guides.rubyonrails.org/active_job_basics.html#enqueue-the-job
    #   - app/jobs/generated_message_job.rb
    #   - GeneratedMessageJob.perform_later( <model> )
    #
    # STEPS:
    #   1. call the background job
    #   2. update the generated message body
    #   3. continue to LAB 04.3 to fix the notification

    if @generated_message.save
      # LAB 02.4
      # ========
      # add a flash notification that the AI text is successfully generated
      #
      # HINT:
      #   - https://guides.rubyonrails.org/action_controller_overview.html#the-flash
      #
      # STEPS:
      #   1. add a flash notification message
      #   2. if all goes well the notification will be correct, the Generated
      #      Text will be updated and the feature spec should be passing.
      #      `bin/rspec spec/features/user_adds_message_to_guestbook_spec.rb`

      # LAB 04.3
      # ========
      # Need to tell the suer that the text is "being generated" and NOT that it has "successfully generated"
      #
      # HINT:
      #   - https://guides.rubyonrails.org/action_controller_overview.html#the-flash
      #
      # STEPS:
      #   1. fix the flash notification messagecheck if the body is present
      #   2. continue to LAB 04.3 to save and correctly notify

      flash.now[:notice] = "AI text successfully generated."
      render :new, status: :see_other
    end
  end

  # @route PATCH /messages/:message_id/generated_messages/:id (message_generated_message)
  # @route PUT /messages/:message_id/generated_messages/:id (message_generated_message)
  def update
    # LAB 02.5
    # ========
    # Although currently not part of the spec, have a play in the browser and
    # you will note that currently you cannot update the AI generated message.
    # Implement the code below to update the message with the passed in
    # parameters.
    #
    # HINT:
    #   - https://guides.rubyonrails.org/action_controller_overview.html#parameters
    #   - model.update( <params> )
    #   - params can be accessed generated_message_params[:generated_message]
    #   - if there are errors, return `status: unprocessable_entity`
    #
    # STEPS:
    #   1. update the model with the parameters
    #   2. test manually in browser that you can update the generated message

    # LAB 04.4
    # ========
    # Need to check if the body has been succesfully generated, if not, say it
    # is being generated, if yes let the user know it has been successfully
    # generated.
    #
    # HINT:
    #   - check if body is present @generated_message.body.present?
    #   - check if the "refresh" button was pressed `if params[:refresh]``
    #
    # STEPS:
    #   1. check if the body is present
    #   2. check if the refresh button was pressed
    #   3. if YES for 1. and 2. above, return still generated
    #   4. otherwise let the user know it has been generated

    if @generated_message.update(generated_message_params[:generated_message])
      redirect_to \
        @generated_message.message,
        notice: "Generated message was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # @route DELETE /messages/:message_id/generated_messages/:id (message_generated_message)
  def destroy
    @generated_message.destroy!

    redirect_to message_path(@message), status: :see_other, notice: "Generated message was successfully destroyed."
  end

  private

  def set_generated_message
    @generated_message = GeneratedMessage.find(params[:id])
    @message = @generated_message.message
  end

  def generated_message_params
    params.permit(:message_id, generated_message: [:body])
  end
end
