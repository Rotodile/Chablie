class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    private

    def logged_in_user
        unless logged_in?
            store_location
            flash[:notice] = "Please log in"
            redirect_to login_url
        end
    end
end
