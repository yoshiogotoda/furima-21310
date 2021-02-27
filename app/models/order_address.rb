class OrderAddress

  include ActiveModel::Model
  attr_accessor :item_id,:user_id,:postal_code,:prefecture_id,:city,:addresses,:building,:phone_number
  
  validates :postal_code, presence: true,format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  with_options presence: true do
    validates :city
    validates :addresses
    validates :phone_number,format: { with: /\A[0-9]{11}\z/ ,message: "is invalid. Exclude hyphen(-)"}
  end

  def save
    order = Order.create(user_id:current_user.id,item_id:item.id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture, city: city, addresses: addresses, building: building,phone_number: phone_number,order_id: order.id)
  end

end