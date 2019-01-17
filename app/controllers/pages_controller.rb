class PagesController < ApplicationController
  def home
    @user = User.new
    if logged_in?
      @chable = current_user.chables.build
      @chables = @user.chables
      @feed_items = current_user.feed
    end
  end

  def about
  end
end
