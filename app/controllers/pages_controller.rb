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
  
  def rechable
    @original_chable = Chable.find(params[:id])
    if @original_chable
      @chable_rechable = current_user.chables.build(content: @original_chable.content, user_id: @original_chable.user_id)
      if new_chable.save
        @rechable = current_user.rechable.build(content: @original_chable.content, user_id: @original_chable.user_id, chable_id: @original_chable.id )
        redirect_to user_path(current_user)
        flash[:notice] = "Rechable Successful"
      else
        redirect_to user_path(current_user), notice: new_chable.errors.full_messages
      end
    else
      # error messages
    end
  end

  def about
  end
end
