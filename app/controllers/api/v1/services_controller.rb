module Api 
  module V1 
    class ServicesController < ApplicationController
      def index 
        services = Service.all 
        render json: {services: serialize_service(services)},status: :ok 
      end



      private 

      def serialize_service(services) 
        items= []
      
        services.each do |service|
          items << {id:service.id,name: service.name,description: service.description,price: service.price,duration:service.duration,status: service.status}
        end
        return items 
      end
    end
  end
end