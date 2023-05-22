class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  def search
     @range = params[:range]

    if @range == "Artist"
      @posts = Post.artist_looks(params[:search],params[:word]).order(created_at: :desc).page(params[:page]).per(10)
    elsif @range =="Song"
      @posts = Post.song_looks(params[:search],params[:word]).order(created_at: :desc).page(params[:page]).per(10)
    elsif @range == "User"
     @users = User.looks(params[:search],params[:word]).order(created_at: :desc).page(params[:page]).per(10)
    else
      @posts = []
    end
  end
end
