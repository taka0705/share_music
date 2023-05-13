class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]

    if @range == "Artist"
      @posts = Post.artist_looks(params[:search],params[:word])
    elsif @range =="Song"
      @posts = Post.song_looks(params[:search],params[:word])
    elsif params[:genre_id]
      @posts = Post.genre_looks(params[:genre_id])
      @genre = Genre.find(params[:genre_id])
    else
      @posts = []
    end



  end


end
