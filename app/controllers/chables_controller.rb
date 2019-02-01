class ChablesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy
    
    def create
        @chable = current_user.chables.build(chable_params)
        if @chable.save
          flash[:notice] = "Your Chable was created!"
          redirect_to root_url
        else
          @feed_items = []
          render 'pages/home'
        end
    end

    def destroy
        @chable.destroy
        flash[:notice] = "Your Chable was deleted!"
        redirect_to request.referrer || root_url    
    end
  
    def rechable
        @original_chable = Chable.first
        if @original_chable
          @chable_rechable = current_user.chables.build(content: @original_chable.content, user_id: @original_chable.user_id)
          if @chable_rechable.save
            @rechable = current_user.rechable.build(content: @original_chable.content, user_id: @original_chable.user_id, chable_id: @original_chable.id )
            redirect_to user_path(current_user)
            flash[:notice] = "Rechable Successful"
          else
            redirect_to user_path(current_user), notice: @chable_rechable.errors.full_messages
          end
        else
         redirect_to root_path
         flash[:notice] = "Something went wrong"
        end
      end 

    private

    def chable_params
        params.require(:chable).permit(:content, :chable_picture)
    end

    def correct_user
        @chable = current_user.chables.find_by(id: params[:id])
        redirect_to root_url if @chable.nil?
    end
end
