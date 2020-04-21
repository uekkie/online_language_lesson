require 'rails_helper'

RSpec.describe Teacher, type: :model do
  let!(:teacher) { create(:teacher) }
  let!(:language) { create(:language, teacher: teacher) }
  let!(:lesson) { create(:lesson, teacher: teacher, language: language) }

  it 'teacherを削除すると、teacherのlessonsも削除されること' do
    expect{ teacher.destroy }.to change{ Lesson.count }.by(-1)
  end

  it 'teacherを削除すると、teacherのreservationsも削除されること' do
    user = create(:user)

    user.reservations.create(lesson: lesson)
    expect(lesson.teacher.reservations.count).to eq 1
    expect{ lesson.teacher.destroy }.to change{ lesson.teacher.reservations.count }.by(-1)
  end



end
