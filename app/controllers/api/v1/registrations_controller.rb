module Api 
  module V1
    class RegistrationsController < Devise::RegistrationsController
      def create
        user = User.new(user_params)

        if user.save
          render json: { token: user.authentication_token, user: user.as_json }, status: :ok
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end

   

   
  end
end