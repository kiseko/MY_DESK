require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let(:other_user) { create(:user) }
    let!(:user) { build(:user) }

    context 'unique_nameカラム' do
      it '空欄でないこと' do
        user.unique_name = ""
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
        user.hundle_name = ""
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
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context 'Followingモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end

      it 'userを削除すると、uerが行ったfollowingも削除される' do
        user.followings.create(following_user_id: other_user.id)
        expect{ user.destroy }.to change{ Following.count }.by(-1)
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

      it 'userを削除すると、uerに関連するitemも削除される' do
        user.items.create(brand: "brand_name", name: "item_name")
        expect{ user.destroy }.to change{ Item.count }.by(-1)
      end
    end

    context 'InstagramLinkモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:instagram_link).macro).to eq :has_one
      end

      it 'userを削除すると、uerに関連するinstagram_linkも削除される' do
        user.create_instagram_link(url: "https://www.instagram.com/username")
        expect{ user.destroy }.to change{ InstagramLink.count }.by(-1)
      end
    end

    context 'TwitterLinkモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:twitter_link).macro).to eq :has_one
      end

      it 'userを削除すると、uerに関連するtwitter_linkも削除される' do
        user.create_twitter_link(url: "https://twitter.com/username")
        expect{ user.destroy }.to change{ TwitterLink.count }.by(-1)
      end
    end
  end
end