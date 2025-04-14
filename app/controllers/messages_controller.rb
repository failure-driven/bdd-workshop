class MessagesController < ApplicationController
  before_action :set_message, only: %i[show edit update destroy]

  # GET /messages or /messages.json
  # @route GET /messages (messages)
  # @route GET / (root)
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  # @route GET /messages/:id (message)
  def show
  end

  # @route GET /messages/new (new_message)
  def new
    @message = Message.new
  end

  # @route GET /messages/:id/edit (edit_message)
  def edit
  end

  # POST /messages or /messages.json
  # @route POST /messages (messages)
  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to messages_path, notice: "Message was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  # @route PATCH /messages/:id (message)
  # @route PUT /messages/:id (message)
  def update
    if @message.update(message_params)
      redirect_to @message, notice: "Message was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1 or /messages/1.json
  # @route DELETE /messages/:id (message)
  def destroy
    @message.destroy!

    redirect_to messages_path, status: :see_other, notice: "Message was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.expect(message: [:body, :name])
  end
end
