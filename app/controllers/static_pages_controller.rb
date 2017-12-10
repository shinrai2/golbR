class StaticPagesController < ApplicationController
  def home
    if logged_in?
      # @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @feed_items = Post.all.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
