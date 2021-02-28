class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)  
     if @order_address.valid?
       payjp
       @order_address.save
       redirect_to root_path
     else
       render action: :index
     end
  end
 
  private
   # 全てのストロングパラメーターを1つに統合
  def order_params
   params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building,:phone_number).merge(user_id:current_user.id,item_id:params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: Item.find(order_params[:item_id]).price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
 
 end