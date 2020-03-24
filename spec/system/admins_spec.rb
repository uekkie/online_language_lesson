require 'rails_helper'

RSpec.describe "Teachers", type: :system do
  let!(:admin) { create(:admin) }

  it "管理者でログイン後、レッスン一覧画面にリダイレクトされる" do
    visit root_path

    click_link "講師ログイン"

    fill_in 'メールアドレス', with: admin.email
    fill_in 'パスワード', with: admin.password

    click_button 'ログイン'

    expect(current_path).to eq teachers_path
  end

  context "ログインしているとき" do

    before { sign_in admin }

    it "講師を追加できる" do
      visit teachers_path

      click_link "講師の追加"

      fill_in '名前', with: "山田"
      fill_in 'メールアドレス', with: "yamada@example.com"
      fill_in 'パスワード', with: "aaaaaa"
      fill_in 'パスワード（確認用）', with: "aaaaaa"

      expect {
        click_on "作成する"
      }.to change{ Teacher.count }.by(1)
    end


    it "講師を削除できる" , js: true do
      create(:teacher)

      visit teachers_path

      within '.teachers' do
        expect {
          click_on "削除", match: :first
          expect(page.driver.browser.switch_to.alert.text).to eq '削除してよろしいですか？'
          page.accept_confirm
          expect(current_path).to eq teachers_path
        }.to change{ Teacher.count }.by(-1)
      end
    end
  end
end

