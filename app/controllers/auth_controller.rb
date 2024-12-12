require 'openssl'
require 'base64'

class AuthController < ApplicationController
  TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN']

  def telegram
    # Parse the incoming callback data
    callback_data = params[:callback_query] || params[:message] || {}
    text = callback_data[:text] || callback_data[:data] || ""
    puts text.inspect
    puts 1111.inspect
    puts callback_data.inspect
    puts 1111.inspect

    # Check if the text contains "Успешная авторизация"
    if text.include?("Успешная авторизация")
      session[:authorized] = true
      redirect_to root_path, notice: "Успешная авторизация"
    else
      session[:authorized] = false
      redirect_to root_path, notice: "Авторизация не удалась"
      end
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
