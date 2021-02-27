require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end
  context '購入ができる' do
    it '必要な情報が入力されると購入できる' do
      expect(@order_address).to be_valid
    end
  end
  context '購入ができない' do
    it '郵便番号が入力されていない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it '郵便番号にハイフンが入力されていない' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it '都道府県が入力されていない' do
      @order_address.prefecture_id = 0
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end
    it '市区町村が入力されていない' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end
    it '番地が入力されていない' do
      @order_address.addresses = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Addresses can't be blank")
    end
    it '電話番号が入力されていない' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it '電話番号にハイフンが含まれている' do
      @order_address.phone_number = '090-9999-9999'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid. Exclude hyphen(-)")
    end
  end
end
