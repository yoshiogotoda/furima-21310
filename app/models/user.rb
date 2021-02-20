class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname
    validates :birth_date
    validates :email
  end
  with_options presence: true, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'Include both letters and numbers' } do
    validates :password
    validates :password_confirmation
  end
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/i, message: ':全角で入力して下さい' } do
    validates :first_name
    validates :last_name
  end   
  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/i, message: ':全角カナで入力して下さい' } do
    validates :last_name_kana
    validates :first_name_kana
  end

  has_many :items
end
