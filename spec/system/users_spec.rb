require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }

  it "ログイン後、予約一覧画面にリダイレクトされる" do
    visit root_path

    click_link "生徒ログイン"

    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password

    click_button 'ログイン'

    expect(current_path).to eq users_reservations_path
  end

end
