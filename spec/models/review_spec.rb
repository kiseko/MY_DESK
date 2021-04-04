require 'rails_helper'

RSpec.describe 'Reviewモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { review.valid? }

    let(:user) { create(:user) }
    let(:item) { create(:item, user_id: user.id) }
    let(:review) { build(:review, item_id: item.id) }

    context 'ratingカラム' do
      it '空欄でないこと' do
        review.rating = ""
        is_expected.to eq false
      end

      it '1~5であること: 0は×' do
        review.rating = 0
        is_expected.to eq false
      end

      it '1~5であること: 1は〇' do
        review.rating = 1
        is_expected.to eq true
      end

      it '1~5であること: 5は〇' do
        review.rating = 5
        is_expected.to eq true
      end

      it '1~5であること: 6は×' do
        review.rating = 6
        is_expected.to eq false
      end
    end

    context 'descriptionカラム' do
      it '空欄でないこと' do
        review.description = ""
        is_expected.to eq false
      end

      it '255文字以下であること: 255文字は〇' do
        review.description = Faker::Lorem.characters(number: 255)
        is_expected.to eq true
      end

      it '255文字以下であること: 256文字は×' do
        review.description = Faker::Lorem.characters(number: 256)
        is_expected.to eq false
      end
    end
  end
end