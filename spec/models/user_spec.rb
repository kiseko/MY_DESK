require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let(:other_user) { create(:user) }
    let!(:user) { build(:user) }

    context 'unique_nameカラム' do
      it '空欄でないこと' do
        user.unique_name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.unique_name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.unique_name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '15文字以下であること: 15文字は〇' do
        user.unique_name = Faker::Lorem.characters(number: 15)
        is_expected.to eq true
      end
      it '15文字以下であること: 16文字は×' do
        user.unique_name = Faker::Lorem.characters(number: 16)
        is_expected.to eq false
      end
      it '一意性があること' do
        user.unique_name = other_user.unique_name
        is_expected.to eq false
      end
    end

    context 'hundle_nameカラム' do
      it '空欄でないこと' do
        user.hundle_name = ''
        is_expected.to eq false
      end
      it '10文字以下であること: 10文字は〇' do
        user.hundle_name = Faker::Lorem.characters(number: 10)
        is_expected.to eq true
      end
      it '10文字以下であること: 11文字は×' do
        user.hundle_name = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do

    context 'Followingモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
    end

    context 'Clipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:clips).macro).to eq :has_many
      end
    end

    context 'Sceneモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:scenes).macro).to eq :has_many
      end
    end

    context 'Itemモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:items).macro).to eq :has_many
      end
    end

    context 'InstagramLinkモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:instagram_link).macro).to eq :has_one
      end
    end

    context 'TwitterLinkモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:twitter_link).macro).to eq :has_one
      end
    end
  end
end