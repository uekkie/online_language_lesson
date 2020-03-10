require 'rails_helper'

RSpec.describe "Teachers", type: :system do
  let!(:teacher) { create(:teacher) }

  it "ログイン後、予約一覧画面にリダイレクトされる" do
    visit root_path

    click_link "講師ログイン"

    fill_in 'メールアドレス', with: teacher.email
    fill_in 'パスワード', with: teacher.password

    click_button 'ログイン'

    expect(current_path).to eq lessons_path
  end

  context "ログインしているとき" do

    before { sign_in teacher }
    let!(:language) { create(:language) }
    let!(:time_table) { create(:time_table) }

    it "レッスンを追加できる" do
      visit lessons_url
      expect(current_path).to eq lessons_path

      click_link "レッスンを追加"

      select language.name, from: "言語"
      select time_table.start_time_format, from: "開始時間"

      expect {
        click_on "登録する"
      }.to change{Lesson.count}.by(1)
    end
  end

  end
