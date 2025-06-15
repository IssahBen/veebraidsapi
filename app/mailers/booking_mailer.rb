class BookingMailer < ApplicationMailer
   def booking_confirmation(booking)
     @name = booking.customer_name 
     service = Service.find(booking.service_id)
     @service = service.name 
     @price =  service.price 
     @date = booking.date.to_date
     @email = booking.email
     @service_type = booking.service_type
     mail(to: @email, subject: "Booking Confirmation")
   end

   def admin_notification(booking) 
    @name = booking.customer_name 
    service = Service.find(booking.service_id)
    @service = service.name 
    @date = booking.date.to_date
    @email = booking.email
    @price =  service.price 
    @service_type = booking.service_type
    mail(to: "benedictissah@gmail.com", subject: "New Booking")
   end

    def booking_cancelled(booking)
      @name = booking.customer_name 
      service = Service.find(booking.service_id)
      @service = service.name 
      @date = booking.date.to_date
      @email = booking.email
      @price =  service.price 
      @service_type = booking.service_type
      mail(to: @email, subject: "Booking Cancelled")
    end
end
