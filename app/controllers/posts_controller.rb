class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    render plain: "I'm in posts#show page"
  end
end
