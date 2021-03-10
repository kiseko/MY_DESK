require 'rails_helper'

RSpec.describe 'InstagramLinkモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { @instagram_link.valid? }

    let(:user) { create(:user) }

    before do
      @instagram_link = user.build_instagram_link
    end

    context 'urlカラム' do
      it '空欄でないこと' do
        @instagram_link.url = ""
        is_expected.to eq false
      end

      it '特定の文字列を含むこと: "https://www.instagram.com/"+"user_name"は〇' do
        @instagram_link.url = "https://www.instagram.com/test"
        is_expected.to eq true
      end

      it '特定の文字列を含むこと: "https://www.instagram.com/"は×' do
        @instagram_link.url = "https://www.instagram.com/"
        is_expected.to eq false
      end

      it '特定の文字列を含むこと: Instagram以外のURLは×' do
        @instagram_link.url = "https://www.sns.com/test"
        is_expected.to eq false
      end
    end
  end
end