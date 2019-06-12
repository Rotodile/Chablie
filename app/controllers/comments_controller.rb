class CommentsController < ApplicationController
    before_action :find_commentable

    def new
      @comment = Comment.new  
    end

    def create
      @comment = @commentable.comments.new comment_params.merge(user_id: current_user.id)
      if @comment.save
        redirect_to root_path, notice: 'Your comment was successfully sent!'
      else
        redirect_to root_path, notice: "Your comment wasn't sent!"
      end
    end

    private
    
    def comment_params
      params.require(:comment).permit(:chable_id, :body)
    end
    
    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Chable.find_by_id(params[:chable_id]) if params[:chable_id]
    end  
end    