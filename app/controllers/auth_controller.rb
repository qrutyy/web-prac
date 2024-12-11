require 'openssl'
require 'base64'

class AuthController < ApplicationController
  TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN']

  def telegram
    auth_data = params.except(:controller, :action)
    if valid_telegram_auth?(auth_data)
      session[:authorized] = true
      render json: { message: 'Успешная авторизация', user: auth_data }
    else
      session[:authorized] = false
      render json: { error: 'Неверные данные авторизации' }, status: :unauthorized
    end
  end

  private

  def valid_telegram_auth?(auth_data)
    data_check_string = auth_data.sort.map { |k, v| "#{k}=#{v}" }.join("\n")
    secret_key = OpenSSL::Digest::SHA256.new.digest(TELEGRAM_TOKEN)
    hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, secret_key, data_check_string)
    hash == auth_data['hash']
  end

def vk_success
    if params[:success]
      session[:authorized] = true
      render json: { message: 'Session updated successfully' }, status: :ok
    else
      render json: { error: 'Authorization failed' }, status: :unprocessable_entity
    end
  end

end
