class Review < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :rating, presence: true
end
