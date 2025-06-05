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
      

      private

      def booking_params
        params.require(:booking).permit(:customer_name, :email, :service, :date, :time,:service_type)
      end
      
    end
  end
end
