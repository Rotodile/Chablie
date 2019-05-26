class PagesController < ApplicationController
  def home
    @user = User.new
    if logged_in?
      @chable = current_user.chables.build
      @chables = @user.chables
      @feed_items = current_user.feed
      @other = current_user.followers
      @hashtags = Tag.all
      @hashtags.each do |hashtag|
        if hashtag.chables == 0
          hashtag.destroy
        elsif hashtag.comments == 0
          hashtag.destroy
        end
      end
    end
  end
  
  def about
  end
end
