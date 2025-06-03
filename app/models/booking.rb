class Booking < ApplicationRecord
  belongs_to :service

  
  enum status: {
    pending: 0,
    completed: 1,
    cancelled: 2
  }
  
end
