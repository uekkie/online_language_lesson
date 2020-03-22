require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:lesson) { create(:lesson) }
  it 'userを削除すると、userのreservationsも削除されること' do
    user = create(:user)

    user.reservations.create(lesson: lesson)
    expect(Reservation.count).to eq(1)

    expect{ user.destroy }.to change{ Reservation.count }.by(-1)
  end
end
