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
    let!(:language) { create(:language, teacher: teacher) }

    it "レッスンを追加できる" do
      visit teachers_lessons_path

      click_link "レッスンを追加"

      select language.name, from: "言語"

      within '.lesson_start_date' do
        select '2020', from: "lesson_start_date_1i"
        select I18n.l(Date.today, format: '%B'), from: "lesson_start_date_2i"
        select '21', from: "lesson_start_date_3i"
        select '7', from: "lesson_start_date_4i", match: :first
        select '0', from: "lesson_start_date_4i", match: :first
      end

      fill_in 'ZoomのURL', with: 'https://zoom.us/test/12345'

      expect {
        click_on "登録する"
      }.to change{ Lesson.count }.by(1)
    end
  end
end

