class GeneratedMessagesController < ApplicationController
  before_action :set_generated_message, only: %i[edit update destroy]

  # @route GET /messages/:message_id/generated_messages/:id/edit (edit_message_generated_message)
  def edit
  end

  # @route POST /messages/:message_id/generated_messages (message_generated_messages)
  def create
    @generated_message = GeneratedMessage.find_or_create_by(generated_message_params)

    if @generated_message.save
      render :new, status: :see_other
    end
  end

  # @route PATCH /messages/:message_id/generated_messages/:id (message_generated_message)
  # @route PUT /messages/:message_id/generated_messages/:id (message_generated_message)
  def update
    if @generated_message.update!(generated_message_params[:generated_message])
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
