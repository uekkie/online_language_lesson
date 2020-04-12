require 'rails_helper'

RSpec.describe "Teachers", type: :system do
  let!(:teacher) { create(:teacher) }

  it "ログイン後、予約一覧画面にリダイレクトされる" do
    visit root_path

    click_link "講師ログイン"

    fill_in 'メールアドレス', with: teacher.email
    fill_in 'パスワード', with: teacher.password

    click_button 'ログイン'

    expect(current_path).to eq teachers_lessons_path
  end

  context "ログインしているとき" do

    before { sign_in teacher }
    let!(:language) { create(:language) }

    it "レッスンを追加できる" do
      visit teachers_lessons_path

      click_link "レッスンを追加"

      select language.name, from: "言語"

      fill_in '日時', with: '2020-03-30'
      select '7', from: "時刻", match: :first

      fill_in 'ZoomのURL', with: 'https://zoom.us/test/12345'

      expect {
        click_on "登録する"
      }.to change{ Lesson.count }.by(1)
    end

    describe '言語のCRUD' do
      it '教えられる言語を追加できる' do
        visit profile_teachers_path
        click_on '教えられる言語を追加'
        fill_in '名前', with: '英語'
        expect{
          click_on '登録する'
        }.to change{teacher.languages.count}.by(1)
      end
      describe '編集・削除' do
        before {
          create(:language)
          visit profile_teachers_path
        }
        it '削除できる' do
          expect{
            click_on '削除'
            expect(page.driver.browser.switch_to.alert.text).to eq '削除してよろしいですか？'
            page.accept_confirm
          }.to change{teacher.languages.count}.by(-1)
        end
      end

    end
  end
end

