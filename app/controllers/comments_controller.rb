class CommentsController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment has been posted!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end