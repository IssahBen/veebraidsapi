class BookingMailer < ApplicationMailer
   def booking_confirmation(booking)
     @name = booking.customer_name 
     service = Service.find(booking.service_id)
     @service = service.name 
     @price =  service.price 
     @date = booking.date.to_date
     @email = booking.email
     mail(to: @email, subject: "Booking Confirmation")
   end

   def admin_notification(booking) 
    @name = booking.customer_name 
    service = Service.find(booking.service_id)
    @service = service.name 
    @date = booking.date.to_date
    @email = booking.email
    @price =  service.price 
    mail(to: "benedictissah@gmail.com", subject: "New Booking")
   end
end
