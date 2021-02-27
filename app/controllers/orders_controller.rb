class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    binding.pry
    @order_address = OrderAddress.new(order_params)   #「UserDonation」に編集
     if @order_address.valid?
       @order_address.save
       redirect_to root_path
     else
       render action: :index
     end
  end
 
  private
   # 全てのストロングパラメーターを1つに統合
  def order_params
   params.permit(:postal_code, :prefecture_id, :city, :addresses, :building,:phone_number).merge(user_id:current_user.id,item_id:params[:item_id])
  end
 
 end