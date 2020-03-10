require 'rails_helper'

RSpec.describe "Teachers", type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:teacher) { create(:teacher) }

  it "ログイン後、予約一覧画面にリダイレクトされる" do
    visit root_path

    click_link "講師ログイン"

    fill_in 'メールアドレス', with: teacher.email
    fill_in 'パスワード', with: teacher.password

    click_button 'ログイン'

    expect(current_path).to eq lessons_path
  end
end
