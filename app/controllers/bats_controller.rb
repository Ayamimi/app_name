class BatsController < ApplicationController
    def create
        like = current_user.bats.create(post_id: params[:post_id]) #user_idとpost_idの二つを代入
        redirect_back(fallback_location: root_path)
    end
        
    def destroy
        like = Bat.find_by(post_id: params[:post_id], user_id: current_user.id)
        like.destroy
        redirect_back(fallback_location: root_path)
    end
end
