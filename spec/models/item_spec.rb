require 'rails_helper'

RSpec.describe Item, type: :model do
    before do
      @item = FactoryBot.build(:item)
    end
    describe "商品出品登録" do
      context '出品登録できるとき' do
        it "入力内容に不備がなければ登録できる" do
          expect(@item).to be_valid
        end
      end
      context '商品出品ができないとき' do
        it "画像が空だと登録できない" do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
        it "商品名が空だと登録できない" do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end
        it "商品説明が空では登録できない" do
          @item.explain = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Explain can't be blank")
        end
        it "カテゴリーが選択されていない" do
          @item.category_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include("Category is not included in the list")
        end
        it "商品の状態が選択されていない" do
          @item.sales_status_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include("Sales status is not included in the list")
        end
        it "配送料の負担が選択されていない" do
          @item.shopping_fee_status_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include("Shopping fee status is not included in the list")
        end
        it "発送元の地域が選択されていない" do
          @item.prefecture_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture is not included in the list")
        end
        it "発送までの日数が選択されていない" do
          @item.scheduled_delivery_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include("Scheduled delivery is not included in the list")
        end
        it "価格が空では登録できない" do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end
        it "価格の範囲が、¥300以上でない" do
          @item.price = 200
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be greater than 300")
        end
        it "価格の範囲が、¥9,999,999以下でない" do
          @item.price = 10000000
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be less than 9999999")
        end
        it "販売価格は半角数字のみ保存可能であること" do
          @item.price = "１１１１１１"
          @item.valid?
          expect(@item.errors.full_messages).to include("Price is not a number")
        end
      end
    end
end

  