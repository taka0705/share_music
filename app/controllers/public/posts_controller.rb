class Public::PostsController < ApplicationController

  def new
    @post=Post.new
  end

  def create
@post = Post.new(post_params)
# 投稿を作成する前にユーザーを適切に設定している
  @post.user_id = current_user.id
if @post.save
  redirect_to post_path(@post)
else
  # エラーメッセージを取得して、新規投稿ページを再表示する
  flash.now[:alert] = "投稿に失敗しました。以下のエラーを修正してください。"
  render :new
end
end

  def index
  end

  def show
    @post=Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def post_params
    params.require(:post).permit(:genre_id,:user_id, :artist_name, :song_title, :title, :content, :post_image)
  end
end
