require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { genre.valid? }

    let(:user) { create(:user) }
    let(:item) { create(:item, user_id: user.id) }
    let(:genre) { build(:genre, item_id: item.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        genre.name = ""
        is_expected.to eq false
      end

      it '30文字以下であること: 30文字は〇' do
        genre.name = Faker::Lorem.characters(number: 30)
        is_expected.to eq true
      end

      it '1~5であること: 31文字は×' do
        genre.name = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
    end
  end
end