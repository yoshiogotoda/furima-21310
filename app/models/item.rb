class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shopping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  
  with_options presence: true do
    validates :name
    validates :explain
    validates :price
  end

  validates :category_id, numericality: { other_than: 0 } 
  validates :sales_status_id, numericality: { other_than: 0 } 
  validates :shopping_fee_status_id, numericality: { other_than: 0 } 
  validates :prefecture_id , numericality: { other_than: 0 } 
  validates :scheduled_delivery_id, numericality: { other_than: 0 } 

end
