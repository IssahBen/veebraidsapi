module Api 
  module V1 
    class ServicesController < ApplicationController
      def index 
        services = Service.all 
        render json: {services: serialize_service(services)},status: :ok 
      end

      def create
        service = Service.new(service_params)
        if params[:service][:image].present?
          service.image.attach(params[:service][:image])
        end

        if service.save
          render json: { message: "Service created successfully", service: service }, status: :created
        else
          render json: { error: "Failed to create service", details: service.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: "Invalid data", details: e.record.errors.full_messages }, status: :unprocessable_entity
      end 

      def update
        service = Service.find(params[:id])
      
        if params[:service][:image].present?
          service.image.purge if service.image.attached?
          service.image.attach(params[:service][:image])
        end
      
        if service.update(service_params)
          render json: { message: "Service updated successfully", service: service }, status: :ok
        else
          render json: { error: "Failed to update service", details: service.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        service = Service.find(params[:id])
        if service.destroy
          render json: { message: "Service deleted successfully" }, status: :ok
        else
          render json: { error: "Failed to delete service", details: service.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Service not found" }, status: :not_found
      end
      private 

      def serialize_service(services) 
        items= []
      
        services.each do |service|
          items << {id:service.id,name: service.name,description: service.description,price: service.price,duration:service.duration,status: service.status,image: service.image.attached? ? url_for(service.image) : nil}
        end
        return items 
      end
      def service_params
        params.require(:service).permit(:name, :description, :price, :duration)
      end
    end
  end
end