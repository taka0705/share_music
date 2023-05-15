class Admin::SearchesController < ApplicationController
  def search
     @range = params[:range]

    if @range == "Artist"
      @posts = Post.artist_looks(params[:search],params[:word])
    elsif @range =="Song"
      @posts = Post.song_looks(params[:search],params[:word])
    elsif @range == "User"
     @users = User.looks(params[:search],params[:word])
    else
      @posts = []
    end
  end
end
