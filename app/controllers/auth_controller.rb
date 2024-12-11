require 'openssl'
require 'base64'

class AuthController < ApplicationController
  TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN']

  def telegram
    # Parse the incoming callback data
    callback_data = params[:callback_query] || params[:message] || {}
    text = callback_data[:text] || callback_data[:data] || ""

    # Check if the text contains "Успешная авторизация"
    if text.include?("Успешная авторизация")
      session[:authorized] = true
      render json: { message: "Успешная авторизация", authorized: true }
    else
      session[:authorized] = false
      render json: { message: "Авторизация не удалась", authorized: false }
    end
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
