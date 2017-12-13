class CommentsController < ApplicationController
    before_action :correct_user, only: :destroy


    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        if @comment.save
            flash[:success] = "Comment success!"
            redirect_to @post
        else
            flash[:info] = "Comment failed."
            redirect_to @post
        end
    #     @post = current_user.posts.build(post_params)
    #     if @post.save
    #         flash[:success] = "Post created!"
    #         redirect_to root_url
    #     else
    #         render new_post_path
    #     end
    end

    def destroy
        post = @comment.post
        @comment.destroy
        flash[:success] = 'Comment was successfully destroyed.'
        respond_to do |format|
          format.html { redirect_to post }
        end
    end

    private

        def correct_user
            @comment = Comment.find(params[:id])
            redirect_to root_url unless current_user?(@comment.post.user)
        end
        
        # Never trust parameters from the scary internet, only allow the white list through.
        def comment_params
            params.require(:comment).permit(:email, :content)
        end
end
