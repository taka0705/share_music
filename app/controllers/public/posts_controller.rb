class Public::PostsController < ApplicationController

  def new
    @post=Post.new
  end

  def create
    @post=Post.new(post_params)
    @post.save
    redirect_to post_path(@post.id)
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def post_params
    params.require(:post).permit(:genre_id,:user_id, :artist_name, :song_title, :title, :content, :post_image)
  end
end
