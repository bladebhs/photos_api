class UsersController < ApplicationController
  def register
    @user = User.create(user_params)
    if @user.save
      response = { message: 'User created successfully' }
      render json: response, status: :created
    else
      render json: @user.errors, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
