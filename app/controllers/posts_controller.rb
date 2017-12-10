class PostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    # GET /posts/1
    # GET /posts/1.json
    def show
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Post created!"
            redirect_to root_url
        else
            @feed_items = []
            render 'static_pages/home'
        end
    end
    
    def destroy
        @post.destroy
        flash[:success] = "Post deleted"
        redirect_back(fallback_location: root_url)
    end

    private
        def correct_user
            @post = current_user.posts.find_by(id: params[:id])
            redirect_to root_url if @post.nil?
        end

        def post_params
            params.require(:post).permit(:content)
        end
end
