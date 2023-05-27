class Public::SearchesController < ApplicationController
before_action :authenticate_user!,only: [:search]

  def search
    @range = params[:range]

    if @range == "Artist"
      @posts = Post.artist_looks(params[:search],params[:word]).order(created_at: :desc).page(params[:page]).per(10)
    elsif @range =="Song"
      @posts = Post.song_looks(params[:search],params[:word]).order(created_at: :desc).page(params[:page]).per(10)
    elsif params[:genre_id]
      @posts = Post.genre_looks(params[:genre_id]).order(created_at: :desc).page(params[:page]).per(10)
      @genre = Genre.find(params[:genre_id])
    elsif @range == "User"
     @users = User.looks(params[:search], params[:word]).where.not(user_status: ["退会","無効"]).order(created_at: :desc).page(params[:page]).per(10)
    else
      @posts = []
    end
  end

end
