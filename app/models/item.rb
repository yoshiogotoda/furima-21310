class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_many_attached :images

  with_options presence: true do
    validates :name,length: {maximum: 40}
    validates :explain,length: {maximum: 400}
    validates :price, numericality: { greater_than: 299,less_than: 10000000 }
    validates :images
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shopping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  
  with_options presence: true, numericality: { other_than: 0 } do
    validates :category_id,            inclusion: { in: 1..10 }
    validates :sales_status_id,        inclusion: { in: 1..6 }
    validates :shopping_fee_status_id, inclusion: { in: 1..2 }
    validates :prefecture_id ,         inclusion: { in: 1..47 }
    validates :scheduled_delivery_id,  inclusion: { in: 1..3 }
  end
end
