class Product < ApplicationRecord
  enum dealing_status: { good: 0, normal: 1, bad: 2 }
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :brand
  belongs_to :size
  belongs_to :category
  belongs_to :shipment
  belongs_to :product_condition
  has_many :favorite_products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :product_imgs

  validate :images_presence
  validates :name, :product_introduction, :category_id, :siza_id, :product_condition_id, :user_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  def images_presence
    if images.attached?
      # inputに保持されているimagesがあるかを確認
      if images.length > 10
        errors.add(:image, '10枚まで投稿できます')
      end
    else
      errors.add(:image, '画像がありません')
    end
  end



end
