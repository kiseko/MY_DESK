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
        item.name = ""
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
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:item) { create(:item, user_id: user.id) }
    let(:scene) { create(:scene, user_id: user.id) }

    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Item.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'ItemPictureモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:item_pictures).macro).to eq :has_many
      end

      it 'itemを削除すると、itemに関連するitem_pictureも削除される' do
        item.item_pictures.create( image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.png')) )
        expect{ item.destroy }.to change{ ItemPicture.count }.by(-1)
      end
    end

    context 'Genreモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:genres).macro).to eq :has_many
      end

      it 'itemを削除すると、itemに関連するgenreも削除される' do
        item.genres.create(name: "genre_name")
        expect{ item.destroy }.to change{ Genre.count }.by(-1)
      end
    end

    context 'SceneItemモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:scene_items).macro).to eq :has_many
      end

      it 'itemを削除すると、itemに関連するscene_itemも削除される' do
        scene.scene_items.create(item_id: item.id)
        expect{ item.destroy }.to change{ SceneItem.count }.by(-1)
      end
    end

    context 'Clipモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:clips).macro).to eq :has_many
      end

      it 'itemを削除すると、itemに関連するclipも削除される' do
        item.clips.create(user_id: other_user.id)
        expect{ item.destroy }.to change{ Clip.count }.by(-1)
      end
    end

    context 'Reviewモデルとの関係' do
      it '1:1となっている' do
        expect(Item.reflect_on_association(:review).macro).to eq :has_one
      end

      it 'itemを削除すると、itemに関連するreviewも削除される' do
        item.create_review(rating: 5, description: "review_text")
        expect{ item.destroy }.to change{ Review.count }.by(-1)
      end
    end

    context 'HomepageLinkモデルとの関係' do
      it '1:1となっている' do
        expect(Item.reflect_on_association(:homepage_link).macro).to eq :has_one
      end

      it 'itemを削除すると、itemに関連するhomepage_linkも削除される' do
        item.create_homepage_link(url: "homepage_url")
        expect{ item.destroy }.to change{ HomepageLink.count }.by(-1)
      end
    end

    context 'AmazonLinkモデルとの関係' do
      it '1:1となっている' do
        expect(Item.reflect_on_association(:amazon_link).macro).to eq :has_one
      end

      it 'itemを削除すると、itemに関連するamazon_linkも削除される' do
        item.create_amazon_link(url: "https://www.amazon.co.jp/product")
        expect{ item.destroy }.to change{ AmazonLink.count }.by(-1)
      end
    end

  end
end