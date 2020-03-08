class Lesson < ApplicationRecord
  belongs_to :teacher
  belongs_to :time_table
end
