module Api 
  module V1
    class BookingsController < ApplicationController
      
      def create
        data = params[:booking]
        service = Service.find_by(name: data[:service])
      
        unless service
          return render json: { message: "Invalid Service" }, status: :unprocessable_entity
        end
      
        booking = Booking.new(
          customer_name: data[:customer_name],
          email: data[:email],
          service_id: service.id,
          date: data[:date],
          time: data[:time],
          service_type: data[:service_type],
          status: :pending
        )
      
        if booking.save
          BookingMailer.booking_confirmation(booking).deliver_now
          BookingMailer.admin_notification(booking).deliver_now
          render json: { message: "success", booking: booking }, status: :ok
        else
          render json: { error: "Failed to create booking", errors: booking.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index 
        dates = []
        Booking.all.each do |booking| 
          dates << booking.date
        end

        render json: { dates: dates}
      end

      def bookings 
        bookings = Booking.all 
        render json: {bookings: serialize_bookings(bookings)}, status: :ok 
      end
      

      private

      def booking_params
        params.require(:booking).permit(:customer_name, :email, :service, :date, :time,:service_type)
      end
      
      def serialize_bookings(bookings)
        items  = []
        bookings.each do |booking|
          items << {
            id: booking.id,
            name: booking.customer_name,
            email: booking.email,
            service: Service.find(booking.service_id).name,
            date: booking.date.to_date,
            service_type: booking.service_type,
            time: booking.time,
            status: booking.status

          }
        end
        return items
      end
    end
  end
end
