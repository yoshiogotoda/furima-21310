require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "ユーザー新規登録/ユーザー情報" do
    it "nicknameが空だと登録できない" do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it "emailが空では登録できない" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "emailが一意性であること" do
      @user.save
      anothor_user = FactoryBot.build(:user)
      anothor_user.email = @user.email
      anothor_user.valid?
      expect(anothor_user.errors.full_messages).to include("Email has already been taken")
    end
    it "emailが@を含む必要がある" do
      @user.email = "11testtest"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email :＠ must be exit")
    end
    it "passwordは、6文字以上での入力が必須" do
      @user.password = "aa111"
      @user.password_confirmation = "aa111"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it "passwordは、半角英数字混合での入力が必須である" do
      @user.password = "aaaaaa"
      @user.password_confirmation = "aaaaaa"  
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers", "Password confirmation Include both letters and numbers")
    end
    it "passwordは、確認用を含めて２回入力すること" do
      @user.password = "aaa111"
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "passwordとpassword(確認用）は値の一致が必須である" do
      @user.password = "aaa111"
      @user.password_confirmation = "bbb222"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
  describe "ユーザー新規登録/本人情報確認" do
    it "ユーザー本名は、名字と名前がそれぞれ必須であることい" do
      @user.last_name = ""
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank","First name can't be blank")
    end
    it "ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
      @user.last_name = "aaaaaa"
      @user.first_name = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name :全角で入力して下さい", "Last name :全角で入力して下さい")
    end
    it "ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること" do
      @user.last_name_kana = ""
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank","First name kana can't be blank")
    end
    it "ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であるこ" do
      @user.last_name_kana = "aaaaaa"
      @user.first_name_kana = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana :全角カナで入力して下さい", "First name kana :全角カナで入力して下さい")
    end
    it "生年月日が必須であること" do
      @user.birth_date = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
