class HomeController < ApplicationController
  def index
    @ping_issue_click_counter ||= 0

    @full_text_of_moby_dick ||= "This is going to be the full text of Moby Dick (~1Mb)"
  end
end
