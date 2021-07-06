class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment has been posted!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find_by_id(params[:id])
    existing_vote = @comment.votes.where(user_id: current_user.id)
    respond_to do |format|
      if existing_vote.empty?
        Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
      else
        existing_vote.first.update(vote: params[:vote])
      end
      @upvote = params[:vote]
      format.html do
        redirect_back fallback_location: root_path
      end
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end