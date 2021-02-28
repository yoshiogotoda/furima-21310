class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item,only: [:index,:create]
  before_action :redirect_top_page,only: [:index,:create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    
     if @order_address.valid?
       pay_item
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

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_top_page
    redirect_to root_path if current_user.id == @item.user_id || @item.order != nil
  end

 
 end

 