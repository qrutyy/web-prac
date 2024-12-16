require 'openssl'
require 'base64'

class AuthController < ApplicationController
  TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN']
def telegram

    first_name = params[:first_name]
    last_name = params[:last_name]
    username = params[:username]

    if first_name != "" 
      session[:authorized] = true
      session[:user] = { id: params[:id], first_name: first_name, last_name: last_name, username: username }
      redirect_to root_path, notice: "Успешная авторизация. Добро пожаловать, #{first_name}!"
    else
      session[:authorized] = false
      redirect_to root_path, notice: "Неудачная авторизация"
    end
  end

  def vk_success
    puts 2222.inspect
    if params[:success]
      session[:authorized] = true
      render json: { message: 'Session updated successfully' }, status: :ok
    else
      render json: { error: 'Authorization failed' }, status: :unprocessable_entity
    end
  end

end
