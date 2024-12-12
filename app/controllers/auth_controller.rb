require 'openssl'
require 'base64'

class AuthController < ApplicationController
  TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN']
def telegram
    # Verify the hash to confirm authenticity

    # If the hash is valid, process the user data
    first_name = params[:first_name]
    last_name = params[:last_name]
    username = params[:username]

    # Example: Save user information in session or database
    session[:authorized] = true
    session[:user] = { id: params[:id], first_name: first_name, last_name: last_name, username: username }

    redirect_to root_path, notice: "Успешная авторизация. Добро пожаловать, #{first_name}!"
  end

  private

  def vk_success
    if params[:success]
      session[:authorized] = true
      render json: { message: 'Session updated successfully' }, status: :ok
    else
      render json: { error: 'Authorization failed' }, status: :unprocessable_entity
    end
  end

end
