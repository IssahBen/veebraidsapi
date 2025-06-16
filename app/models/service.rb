class Service < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :duration, presence: true
end
