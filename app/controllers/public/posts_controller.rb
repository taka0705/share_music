class Public::PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_guest_user, only: [:edit,:new]
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
    @posts=Post.all.order(created_at: :desc)
    @genres=Genre.all
  end

  def show
    @post=Post.find(params[:id])
    @post_comment = PostComment.new
    @user=@post.user
  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "変更が成功しました。"
    else
      render "edit"
    end
  end


private
  def post_params
    params.require(:post).permit(:genre_id,:user_id, :artist_name, :song_title, :title, :content, :post_image)
  end

  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザー新規投稿や編集ができません。'
    end
  end



end
