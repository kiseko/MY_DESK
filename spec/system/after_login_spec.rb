require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end

  describe 'ユーザデスク画面のテスト:　自分のページ(シーンなし)' do
    before do
      visit user_path(user)
    end

    context '表示内容の確認' do
      it 'デスクの非公開ボタンが表示される' do
        expect(page).to have_css ".close-button"
      end

      it 'プロフィール編集画面のリンクが表示される' do
        expect(page).to have_link "プロフィールの編集"
      end

      it 'SNSリンク設定画面のリンクが表示される' do
        expect(page).to have_link "SNSリンクの設定"
      end

      it 'シーン新規作成画面のリンクが表示される' do
        link = find(".scene-plus-field a")
        expect(link[:href]).to eq new_user_scene_path(user)
      end
    end
  end

  describe 'ユーザデスク画面のテスト:　自分のページ(シーンあり)' do
    let(:user) { create(:user) }
    let!(:scene){ create(:scene, user_id: user.id) }

    before do
      visit user_path(user)
    end

    context '表示内容の確認' do
      it 'シーンの削除ボタンが表示される' do
        link = find(".scene-delete a")
        expect(link[:href]).to eq user_scene_path(user, scene.id)
      end

      it 'シーンアイテム追加画面のリンクが表示される' do
        link = find(".new-scene-item-link")
        expect(link[:href]).to eq new_scene_item_path(scene.id)
      end
    end
  end

  describe 'ユーザデスク画面のテスト:　自分のページ(シーンあり, シーンアイテムあり)' do
    let(:user) { create(:user) }
    let(:item) { create(:item, user_id: user.id) }
    let!(:scene){ create(:scene, user_id: user.id) }

    before do
      scene.scene_items.create(item_id: item.id)
      visit user_path(user)
    end

    context '表示内容の確認' do
      it 'シーンアイテムの削除ボタンが表示される' do
        link = find(".card-information a:last-child")
        expect(link[:href]).to eq scene_item_path(scene.id, scene.scene_items.first.id)
      end

      it 'シーンアイテム詳細画面のリンクが表示される' do
        link = find(".item-detail-link")
        expect(link[:href]).to eq item_path(item.id)
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    before do
      click_link "ログアウト"
    end

    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq "/"
      end
    end
  end

end