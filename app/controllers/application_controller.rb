class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # required to work in Github Codespaces
  skip_before_action :verify_authenticity_token if Rails.env.local?
end
