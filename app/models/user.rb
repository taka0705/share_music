class User < ApplicationRecord
  has_one_attached :user_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :post_favorites,dependent: :destroy
  has_many :post_comments,dependent: :destroy

  has_many :posts,dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



    enum user_status: {有効: 0,退会: 1,無効: 2}


     def get_image
    (user_image.attached?) ? user_image : 'no_image.jpg'
     end


  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def self.looks(search,word)
    if search =="perfect_match"
      @user = User.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  def active_for_authentication?
    super && user_status == "有効" # ユーザーがログインするためには、active?がtrueを返すことも必要
  end

end
