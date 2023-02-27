class CommentsController < ApplicationController

    before_action :authenticate_user!
        
    
def create
        post = Post.find(params[:post_id])
        comment = post.comments.build(comment_params) #buildを使い、contentとpost_idの二つを同時に代入
        comment.user_id = current_user.id
    if comment.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path)
    else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
    end
end

def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
end
            
def update
    comment = Comment.find(params[:id])
    @post = comment.post
    if comment.update(comment_params)
        redirect_to @post
    else
        redirect_to :action => "edit"
    end
end

def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: post_path)
end
            
private
            
    def comment_params
        params.require(:comment).permit(:content)
    end
end
