class Post < ApplicationRecord
  has_one_attached :post_image

    belongs_to :user
    belongs_to :genre

    has_many :post_favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    
    
     def get_image
    (post_image.attached?) ? post_image : 'no_image.jpg'
     end
    

end
