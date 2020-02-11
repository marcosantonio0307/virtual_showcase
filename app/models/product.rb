class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_one_attached :photo, dependent: :destroy

  def thumbnail
  	return self.photo.variant(resize: '300x300')
  end
end
