class ItemsController < ApplicationController
  before_action :authenticate_user!,except: [:index,:show]
  before_action :set_item,only: [:show,:edit,:update,:destroy]
  before_action :redirect_top_page,only: [:edit,:update,:destroy]
  
  def index
   @items = Item.order("created_at DESC")
  end
  def new
   @item = Item.new
  end

  def create
   @item = Item.new(item_params)
   if @item.save
    redirect_to root_path
   else
    render :new
   end
  end

  def show
   
  end

  def edit
    
  end

  def update
    
   if @item.update(item_params)
    redirect_to root_path
   else
    render :edit
   end
  end

  def destroy
      @item.destroy
      redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :explain, :category_id, :sales_status_id, :shopping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price, images: []).merge(user_id:current_user.id)  
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_top_page
    if current_user.id != @item.user_id
      redirect_to root_path
    elsif @item.order.id != nil
      redirect_to root_path
    end
  end

end
