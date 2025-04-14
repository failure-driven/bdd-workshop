# frozen_string_literal: true

class HomeController < ApplicationController
  # @route GET /home (home)
  def show
  end

  # @route POST /home/seed (seed_home)
  def seed
    Message.destroy_all
    Message.create!(
      body:
        "Cool place, I guess. Might hack it later. Just kidding. Or am " \
        "I? ;) Thanks for having me.",
      name: "Darlene",
    )
    Message.create!(
      body:
        "This is perfection. A place worthy of my presence. Thank you " \
        "for hosting me in such an impeccable manner.",
      name: "Tyrell",
    )
    redirect_to root_path, notice: "DB re-seeded!", status: :see_other
  end
end
