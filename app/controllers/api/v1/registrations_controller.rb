module Api 
  module V1
    class Registrations < Devise::RegistrationsController
      def create
        user = User.new(user_params)

        if user.save
          UserMailer.welcome_email(user).deliver_now
          render json: { token: user.authentication_token, user: user.as_json }, status: :ok
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name)
    end
  end
end