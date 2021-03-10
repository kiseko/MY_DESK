require 'rails_helper'

RSpec.describe 'TwitterLinkモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { @twitter_link.valid? }

    let(:user) { create(:user) }

    before do
      @twitter_link = user.build_twitter_link
    end

    context 'urlカラム' do
      it '空欄でないこと' do
        @twitter_link.url = ""
        is_expected.to eq false
      end

      it '特定の文字列を含むこと: "https://www.twitter.com/"+"user_name"は〇' do
        @twitter_link.url = "https://twitter.com/test"
        is_expected.to eq true
      end
      
      it '特定の文字列を含むこと: "https://www.twitter.com/"は×' do
        @twitter_link.url = "https://twitter.com/"
        is_expected.to eq false
      end
      
      it '特定の文字列を含むこと: Twitter以外のURLは×' do
        @twitter_link.url = "https://sns.com/test"
        is_expected.to eq false
      end
    end
  end
end