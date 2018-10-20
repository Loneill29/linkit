class Question < ApplicationRecord
  has_many :answers

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
end
