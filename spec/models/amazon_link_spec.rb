require 'rails_helper'

RSpec.describe 'AmazonLinkモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { @amazon_link.valid? }

    let(:user) { create(:user) }
    let(:item) { create(:item, user_id: user.id) }

    before do
      @amazon_link = item.build_amazon_link
    end

    context 'urlカラム' do
      it '空欄でないこと' do
        @amazon_link.url = ""
        is_expected.to eq false
      end

      it '特定の文字列を含むこと: "https://www.amazon.co.jp/"+"product_code"は〇' do
        @amazon_link.url = "https://www.amazon.co.jp/abc123"
        is_expected.to eq true
      end

      it '特定の文字列を含むこと: "https://www.amazon.co.jp/"は×' do
         @amazon_link.url = "https://www.amazon.co.jp/"
        is_expected.to eq false
      end

       it '特定の文字列を含むこと: Amazon以外のURLは×' do
         @amazon_link.url = "https://www.nile.co.jp/abc123"
        is_expected.to eq false
      end
    end
  end
end