require 'rails_helper'

RSpec.describe 'Itemモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { item.valid? }

    let(:user) { create(:user) }
    let!(:item) { build(:item, user_id: user.id) }

    context 'brandカラム' do
      it '14文字以下であること: 14文字は〇' do
        item.brand = Faker::Lorem.characters(number: 14)
        is_expected.to eq true
      end
      it '14文字以下であること: 15文字は×' do
        item.brand = Faker::Lorem.characters(number: 15)
        is_expected.to eq false
      end
    end

    context 'nameカラム' do
      it '空欄でないこと' do
        item.name = ''
        is_expected.to eq false
      end
      it '14文字以下であること: 14文字は〇' do
        item.name = Faker::Lorem.characters(number: 14)
        is_expected.to eq true
      end
      it '200文字以下であること: 15文字は×' do
        item.name = Faker::Lorem.characters(number: 15)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do

    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Item.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'ItemPictureモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:item_pictures).macro).to eq :has_many
      end
    end

    context 'Genreモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:genres).macro).to eq :has_many
      end
    end

    context 'SceneItemモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:scene_items).macro).to eq :has_many
      end
    end

    context 'Clipモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:clips).macro).to eq :has_many
      end
    end

    context 'Reviewモデルとの関係' do
      it '1:1となっている' do
        expect(Item.reflect_on_association(:review).macro).to eq :has_one
      end
    end

    context 'HomepageLinkモデルとの関係' do
      it '1:1となっている' do
        expect(Item.reflect_on_association(:homepage_link).macro).to eq :has_one
      end
    end

    context 'AmazonLinkモデルとの関係' do
      it '1:1となっている' do
        expect(Item.reflect_on_association(:amazon_link).macro).to eq :has_one
      end
    end

  end
end