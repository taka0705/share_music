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
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post)
    else
      # エラーメッセージを取得して、新規投稿ページを再表示する
      flash.now[:alert] = "投稿に失敗しました。以下のエラーを修正してください。"
      render :new
    end
  end

  def index
    @posts=Post.includes(:user).where(users: {user_status: "有効"}).order(created_at: :desc).page(params[:page]).per(10)
    @genres=Genre.all
  end

  def show
    @post=Post.includes(:user).find_by(id: params[:id], users: { user_status: "有効" })
     if @post.nil?
    flash[:error] = "指定された投稿は存在しないか、非表示にされています。"
    redirect_to root_path
     end
    @post_comment = PostComment.new
    @user=Post.find(params[:id]).user
  end

  def edit
    @post=Post.find(params[:id])
    if @post.user != current_user
      redirect_to post_path(@post),notice: '他のユーザーの投稿を編集することはできません。'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "変更が成功しました。"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path,notice: "削除が成功しました。"
  end


private
  def post_params
    params.require(:post).permit(:genre_id,:user_id, :artist_name, :song_title, :title, :content, :post_image)
  end

  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to posts_path , notice: 'ゲストユーザーは新規投稿や編集ができません。'
    end
  end



end
