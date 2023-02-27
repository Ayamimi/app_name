class UsersController < ApplicationController
    def show
        @username = current_user.username
        @posts = current_user.posts
        @user = User.find(params[:id]) 
        
    end
end
