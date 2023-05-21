class Post < ApplicationRecord
  has_one_attached :post_image

    belongs_to :user
    belongs_to :genre

    has_many :post_favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy

    validates :artist_name, presence: true

    validates :song_title, presence: true

    validates :content, presence: true


    def favorite?(user)
     post_favorites.where(user_id: user.id).exists?
    end

     def get_image
    (post_image.attached?) ? post_image : 'no_image.jpg'
     end

  def self.artist_looks(search,word)
    if search =="perfect_match"
      @post = Post.where("artist_name LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("artist_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("artist_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("artist_name LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

  def self.song_looks(search,word)
    if search =="perfect_match"
      @post = Post.where("song_title LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("song_title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("song_title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("song_title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end



  def self.genre_looks(genre_id)

      @post = Post.where(genre_id: genre_id)

  end




end
