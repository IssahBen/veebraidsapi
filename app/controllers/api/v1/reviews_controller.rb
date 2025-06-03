module Api 
  module V1
    class ReviewsController < ApplicationController
      def create 
        p params
        review = Review.create(review_params)
        if review.save
          render json: { message: "success" }, status: :ok 
        else 
          render json: { error: "Review unable to save", details: review.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index 
        reviews = Review.all 
        render json: { reviews: reviews }
      end

      private

      def review_params
        params.require(:review).permit(:name, :review, :rating)
      end
    end
  end
end
