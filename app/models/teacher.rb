class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lessons
  has_many :reservations
  #has_many :reserved_lessons, through: :reservations, source: :lesson, class_name: "Lesson"
end
