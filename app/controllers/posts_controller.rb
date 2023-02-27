class PostsController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]

    def index
        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(5)
        if params[:search] != nil && params[:search] != ''
            search = params[:search]
            @posts = Post.where("body LIKE ? OR title LIKE ?", "%#{search}%", "%#{search}%")
        else
            @posts = Post.all
        end
    
    end
    
    def new
        @post = Post.new
    end

    def create
        post = Post.new(post_params)
        post.user_id = current_user.id
        tag_list = params[:post][:name].split(/[[:blank:]]+/).select(&:present?)
        post.user_id = current_user.id
        url = params[:post][:youtube_url] # 取得したい情報を指定
        url = url.last(11)                # 11桁の値(video_id)を取り出し、変数urlに格納
        post.youtube_url = url    
        if post.save
            post.save_tag(tag_list)
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end

    def random
        if params[:search] != nil && params[:search] != ''
            search = params[:search]
            @random_posts = Post.order("RANDOM()").where("body LIKE ? OR title LIKE ?", "%#{search}%", "%#{search}%")
        else
            @random_posts = Post.order("RANDOM()").all
        end 
    end

    def ranking
        if params[:search] != nil && params[:search] != ''
            search = params[:search]
            @rank_posts = Post.where("body LIKE ? OR title LIKE ?", "%#{search}%", "%#{search}%").find(Like.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) desc').pluck(:post_id))
        else
            @rank_posts = Post.find(Like.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) desc').pluck(:post_id))
        end 
    end
    
    def search
        @tag = Tag.find(params[:tag_id]) #idに対応したタグのレコードを@tagに代入
        @posts = @tag.posts.all #タグに紐づいた全ての投稿を@postsに代入
    end
    
    def show
        @post = Post.find(params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        post= Post.find(params[:id])
        if post.update(post_params)
        redirect_to :action => "show", :id => post.id
        else
        redirect_to :action => "new"
        end
    end

    def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :index
    end

    private
    def post_params
        params.require(:post).permit(:body,:title,:video,:youtube_url,:image1,:image2,:image3,:image4,:image5,:name)
    end
end

