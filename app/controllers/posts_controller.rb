class PostsController < ApplicationController
    before_action :set_post, only: :show
    before_action :logged_in_user, only: [:new, :create, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]

    def index
        redirect_to root_url
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Post created!"
            redirect_to root_url
        else
            render new_post_path
        end
    end

    # GET /posts/1/edit
    def edit
        @post = Post.find(params[:id])
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
        respond_to do |format|
            if @post.update(post_params)
                flash[:success] = 'Post was successfully updated.'
                format.html { redirect_to root_url }
            else
                format.html { render 'edit' }
            end
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

        def set_post
            @post = Post.find(params[:id])
        end

        def post_params
            params.require(:post).permit(:content, :title)
        end
end
