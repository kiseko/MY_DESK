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
    let!(:scene){ create(:scene, user_id: user.id) }

    before do
      visit user_path(user)
    end

    context '表示内容の確認' do
      it 'シーン画像の変更ボタンが表示される' do
        expect(page).to have_link "シーン画像の変更"
      end

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
    let(:item) { create(:item, user_id: user.id) }
    let!(:scene){ create(:scene, user_id: user.id) }

    before do
      scene.scene_items.create(item_id: item.id)
      visit user_path(user)
    end

    context '表示内容の確認' do
      it 'シーンアイテムの削除ボタンが表示される' do
        link = find(".scene-item-delete")
        expect(link[:href]).to eq scene_item_path(scene.id, scene.scene_items.first.id)
      end

      it 'シーンアイテム詳細画面のリンクが表示される' do
        link = find(".item-detail-link")
        expect(link[:href]).to eq item_path(item.id)
      end
    end
  end


  describe 'ユーザデスク画面のテスト:　他のユーザーのページ' do
    let(:other_user) { create(:user) }
    let(:item) { create(:item, user_id: other_user.id) }
    let!(:scene){ create(:scene, user_id: other_user.id) }

    before do
      scene.scene_items.create(item_id: item.id)
      visit user_path(other_user)
    end

    context '表示内容の確認' do
      it 'フォローボタンが表示される' do
        expect(page).to have_css ".follow-button"
      end

      it 'クリップボタンが表示される' do
        expect(page).to have_css ".clip-button"
      end

      it 'デスクの非公開ボタンが表示されない' do
        expect(page).not_to have_css ".close-button"
      end

      it 'プロフィール編集画面のリンクが表示されない' do
        expect(page).not_to have_link "プロフィールの編集"
      end

      it 'SNSリンク設定画面のリンクが表示されない' do
        expect(page).not_to have_link "SNSリンクの設定"
      end

      it 'シーン画像の変更ボタンが表示されない' do
        expect(page).not_to have_link "シーン画像の変更"
      end

      it 'シーン新規作成画面のリンクが表示されない' do
        expect(page).not_to have_css ".scene-plus-field a"
      end

      it 'シーンの削除ボタンが表示されない' do
        expect(page).not_to have_css ".scene-delete a"
      end

      it 'シーンアイテム追加画面のリンクが表示されない' do
        expect(page).not_to have_css ".new-scene-item-link"
      end

      it 'シーンアイテムの削除ボタンが表示されない' do
        expect(page).not_to have_css ".scene-item-delete"
      end
    end
  end


  describe 'シーンアイテム追加画面のテスト' do
    let!(:item) { create(:item, user_id: user.id) }
    let!(:scene){ create(:scene, user_id: user.id) }

    before do
      visit user_path(user)
      find(".new-scene-item-link").click
    end

    context '表示内容の確認' do
      it 'アイテム作成画面のリンクが表示される' do
        link = find(".new-item-link")
        expect(link[:href]).to eq new_item_path
      end

      it 'シーンアイテム追加ボタンが表示される' do
        expect(page).to have_css ".circle-plus-button"
      end

      it 'シーンアイテム追加ボタンが表示される' do
        expect(page).to have_css ".circle-plus-button"
      end
    end

    context 'データベースの確認' do
      it 'シーンアイテムが追加される' do
        expect { all(".circle-plus-button").first.click }.to change{ SceneItem.count }.by(1)
      end
    end
  end


  describe 'SNSリンク設定画面のテスト' do
    before do
      visit user_path(user)
      click_link "SNSリンクの設定"
      fill_in "instagram_link[url]", with: "https://www.instagram.com/test"
      fill_in "twitter_link[url]", with: "https://twitter.com/test"
    end

    context 'データベースの確認' do
      it 'Instagramのリンクが正しく登録される' do
        expect { find(".instagram .link-button").click }.to change{ InstagramLink.count }.by(1)
      end

      it 'Instagramのリンク公開範囲が正しく登録される: 全員に公開' do
        select "全員に公開", from: "instagram_link[status]"
        find(".instagram .link-button").click
        expect(user.instagram_link.status).to eq 0
      end

      it 'Instagramのリンク公開範囲が正しく登録される: フォロー先のみ公開' do
        select "フォロー先のみ公開", from: "instagram_link[status]"
        find(".instagram .link-button").click
        expect(user.instagram_link.status).to eq 1
      end

      it 'Instagramのリンク公開範囲が正しく登録される: お気に入りのみ公開' do
        select "お気に入りのみ公開", from: "instagram_link[status]"
        find(".instagram .link-button").click
        expect(user.instagram_link.status).to eq 2
      end

      it 'Instagramのリンクが正しく削除される' do
        find(".instagram .link-button").click
        click_link "SNSリンクの設定"
        expect { find(".instagram .icon-link-button").click }.to change{ InstagramLink.count }.by(-1)
      end


      it 'Twitterのリンクが正しく登録される' do
        expect { find(".twitter .link-button").click }.to change{ TwitterLink.count }.by(1)
      end

       it 'Twitterのリンク公開範囲が正しく登録される: 全員に公開' do
        select "全員に公開", from: "twitter_link[status]"
        find(".twitter .link-button").click
        expect(user.twitter_link.status).to eq 0
      end

      it 'Twitterのリンク公開範囲が正しく登録される: フォロー先のみ公開' do
        select "フォロー先のみ公開", from: "twitter_link[status]"
        find(".twitter .link-button").click
        expect(user.twitter_link.status).to eq 1
      end

      it 'Twitterのリンク公開範囲が正しく登録される: お気に入りのみ公開' do
        select "お気に入りのみ公開", from: "twitter_link[status]"
        find(".twitter .link-button").click
        expect(user.twitter_link.status).to eq 2
      end

      it 'Twitterのリンクが正しく削除される' do
        find(".twitter .link-button").click
        click_link "SNSリンクの設定"
        expect { find(".twitter .icon-link-button").click }.to change{ TwitterLink.count }.by(-1)
      end
    end
  end


  describe 'フォロー中一覧画面のテスト' do
    let!(:other_user) { create(:user) }

    before do
      user.followings.create(following_user_id: other_user.id)
      click_link "フォロー中"
    end

    context '表示内容の確認' do
      it 'フォローしたユーザーが表示される' do
        expect(page).to have_css ".following"
      end

      it 'フォロー中ボタンが表示される' do
        expect(page).to have_button "フォロー中"
      end

      it 'お気に入りボタンが表示される' do
        expect(page).to have_css ".fa-bookmark"
      end
    end
  end


  describe 'フォロワー一覧画面のテスト' do
    let!(:other_user) { create(:user) }

    before do
      other_user.followings.create(following_user_id: user.id)
      click_link "フォロワー"
    end

    context '表示内容の確認' do
      it 'フォロワーが表示される' do
        expect(page).to have_css ".following"
      end

      it 'フォローするボタンが表示される' do
        expect(page).to have_button "フォローする"
      end
    end
  end


  describe 'アイテム検索結果画面のテスト' do
    let!(:item) { create(:item, user_id: user.id, name: "スピーカー") }

    before do
      fill_in "item-input", with: "スピーカー"
      find(".item-search-button").click
    end

    context '表示内容の確認' do
      it '検索した文字が表示される' do
        expect(page).to have_field "item-search-result", with: "スピーカー"
      end
    end
  end


  describe '退会画面のテスト' do
    before do
      click_on "ユーザーの設定"
      click_on "退会"
    end

    context '表示内容の確認' do
      it 'アカウント削除ボタンが表示される' do
        expect(page).to have_button "アカウント削除"
      end
    end
  end


  describe 'アイテム一覧画面のテスト' do
    let!(:item) { create(:item, user_id: user.id) }
    let!(:item_picture) { create(:item_picture, item_id: item.id) }

    before do
      click_on "アイテム一覧"
    end

    context '表示内容の確認' do
      it 'アイテム作成画面のリンクが表示される' do
        expect(page).to have_css ".new-item-link"
      end

      it 'アイテムのサムネイルが表示される' do
        expect(page).to have_css ".thumbnail"
      end

      it 'クリップ数のカウントが表示される' do
        expect(page).to have_css ".clip-count-field"
      end
    end

    context 'データベースの確認' do
      it 'アイテムが正しく削除される' do
        expect { all(".item-delete").last.click }.to change{ Item.count }.by(-1)
      end
    end
  end


  describe 'アイテム詳細画面のテスト:　自分のページ(レビューなし)' do
    let!(:item) { create(:item, user_id: user.id) }
    let!(:item_picture) { create(:item_picture, item_id: item.id) }

    before do
      click_on "アイテム一覧"
      all(".item-detail-link").first.click
      fill_in "genre[name]", with: "ガジェット"
    end

    context '表示内容の確認' do
      it 'アイテム画像変更画面のリンクが表示される' do
        expect(page).to have_link "アイテム画像の変更"
      end

      it 'アイテム画像追加画面のリンクが表示される' do
        expect(page).to have_css ".new-picture-link"
      end

      it 'アイテム編集画面のリンクが表示される' do
        expect(page).to have_link "アイテム情報の編集"
      end

      it 'アイテムリンク設定画面のリンクが表示される' do
        expect(page).to have_link "アイテムリンクの設定"
      end

      it 'レビュー作成画面のリンクが表示される' do
        expect(page).to have_button "レビューを作成"
      end

      it 'アイテム作成者のデスク詳細画面のリンクが表示される' do
        expect(page).to have_css ".desk-link"
      end

      it 'ジャンル削除ボタンが表示される' do
        find(".circle-plus-button").click
        expect(page).to have_css ".genre-delete"
      end
    end

    context 'データベースの確認' do
      it 'ジャンルが正しく登録される' do
        expect { find(".circle-plus-button").click }.to change{ Genre.count }.by(1)
      end

      it 'ジャンルが正しく削除される' do
        find(".circle-plus-button").click
        expect { find(".genre-delete").click }.to change{ Genre.count }.by(-1)
      end
    end
  end


  describe 'アイテム詳細画面のテスト:　他ユーザーのページ' do
    let(:other_user) { create(:user) }
    let!(:item) { create(:item, user_id: other_user.id) }
    let!(:item_picture) { create(:item_picture, item_id: item.id) }

    before do
      visit item_path(item.id)
    end

    context '表示内容の確認' do
      it 'クリップボタンが表示される' do
        expect(page).to have_css ".clip-button"
      end

      it '戻るボタンが表示される' do
        expect(page).to have_button "戻る"
      end
    end
  end


  describe 'レビュー作成画面のテスト' do
    let!(:item) { create(:item, user_id: user.id) }
    let!(:item_picture) { create(:item_picture, item_id: item.id) }

    before do
      visit item_path(item.id)
      find(".new-review-link").click
    end

    context '表示内容の確認' do
      it 'アイテム画像が表示される' do
        expect(page).to have_css ".item-picture"
      end
    end

    context 'データベースの確認' do
      it 'レビューが正しく登録される' do
        choose "review_rating_5"
        fill_in "review[description]", with: "気に入ってます。"
        expect { click_button "作成" }.to change{ Review.count }.by(1)
      end
    end
  end

  describe 'メールアドレス変更画面のテスト' do

    before do
      click_on "ユーザーの設定"
    end

    context 'データベースの確認' do
      it 'メールアドレスが正しく変更される' do
        fill_in "user[email]", with: "test@gmail.com"
        click_button "変更"
        click_on "ユーザーの設定"
        expect(page).to have_field "メールアドレス", with: "test@gmail.com"
      end
    end
  end


  describe '退会画面のテスト' do

    before do
      click_on "ユーザーの設定"
      click_on "退会"
    end

    context '表示内容の確認' do
      it 'アカウント削除ボタンが表示される' do
        expect(page).to have_button "アカウント削除"
      end
    end
  end


  describe 'ユーザログアウトのテスト' do
    before do
      find(".log-out").click
    end

    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq "/"
      end
    end
  end


end