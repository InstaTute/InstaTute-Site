class Course < ApplicationRecord
  has_and_belongs_to_many :tutors
  has_and_belongs_to_many :users
  has_many :sessions
  
end
