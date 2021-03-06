class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 3)
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save 
      flash[:notice] = 'Your post has been created.'
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Your post has been updated.'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    existing_vote = @post.votes.where(user_id: current_user.id)
    respond_to do |format|
      if existing_vote.empty?
        Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
      else
        existing_vote.first.update(vote: params[:vote])
      end
      @upvote = params[:vote]
      format.html do
        redirect_back fallback_location: root_path
      end
      format.js { render 'vote', layout: false }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator
    access_denied unless logged_in? && (current_user == @post.creator || current_user.admin?) 
  end

end
