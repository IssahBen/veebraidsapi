module Api
  module V1
    class SessionsController < ApplicationController

      def create
        user = User.find_by(email: user_params[:email])
        
        if user&.valid_password?(user_params[:password])
          if user.authentication_token.blank?
            user.authentication_token = Devise.friendly_token
            user.save
          end

          render json: { token: user.authentication_token, user: user.as_json }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        user = current_user
        if user
          user.authentication_token = Devise.friendly_token
          user.save
          render json: { message: 'Logged out successfully' }
        else
          render json: { error: 'User not authenticated' }, status: :unauthorized
        end
      end

      def update
        user = current_user

        unless user&.valid_password?(params[:user][:currentPassword])
          return render json: { error: 'Incorrect current password' }, status: :unauthorized
        end

        if params[:user][:newPassword].present?
          if params[:user][:newPassword] != params[:user][:confirmPassword]
            return render json: { error: 'Password confirmation does not match' }, status: :unprocessable_entity
          end

          user.password = params[:user][:newPassword]
          user.password_confirmation = params[:user][:confirmPassword]
        end

        user.email = params[:user][:email] if params[:user][:email].present?

        if user.save
          render json: {
            message: 'User updated successfully',
            user: user.as_json(except: [:encrypted_password, :authentication_token])
          }, status: :ok
        else
          render json: { error: 'Update failed', details: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def update_params
        params.require(:user).permit(:email, :currentPassword, :newPassword, :confirmPassword)
      end

    end
  end
end
