class OutsController < ApplicationController

    def create
        post = Post.find(params[:post_id])
        comment = Comment.find(params[:comment_id])
        @out = Out.create(user_id: current_user.id, post_id: post.id, comment_id: comment.id)
        redirect_to post_path(comment.post)
    end
    
    def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:comment_id])
    Out.find_by(user_id: current_user.id, post_id: post.id, comment_id: comment.id).destroy
    redirect_to post_path(comment.post)
    end
    
end
