# frozen_string_literal: true

module PauseSpec
  def spec_pause
    # for debugging only
    binding.irb if ENV.fetch("SPEC_PAUSE", false) # rubocop:disable Lint/Debugger
  end
end
