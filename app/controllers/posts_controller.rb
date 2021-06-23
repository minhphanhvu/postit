class PostsController < ApplicationController
  def index
    render plain: "I'm in posts#index page"
  end

  def show
    render plain: "I'm in posts#show page"
  end
end
