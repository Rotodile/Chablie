class LikesController < ApplicationController
    before_action :find_chable
    before_action :find_like, only: [:destroy]

    def create
        if already_liked?
            flash[:notice] = "You can't like more than once"
        else
            @chable.likes.create(user_id: current_user.id)
        end
        redirect_to root_path
    end

    def destroy
        if !(already_liked?)
          flash[:notice] = "Cannot unlike"
        else
          @like.destroy
        end
        redirect_to root_path
    end
    
      private
    
      def find_chable
        @chable = Chable.find(params[:chable_id])
      end

      def find_like
        @like = @chable.likes.find(params[:id])
      end

      def already_liked?
        Like.where(user_id: current_user.id, chable_id:
        params[:chable_id]).exists?
      end
end
