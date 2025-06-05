class Booking < ApplicationRecord
  belongs_to :service

  # Enum for booking status
  enum status: {
    pending: 0,
    completed: 1,
    cancelled: 2
  }

  # Validations
  validates :customer_name, presence: true
  validates :date, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, presence: true
end
