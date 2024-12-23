require 'openssl'
require 'base64'

class AuthController < ApplicationController
  TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN']

  def telegram
    first_name = params[:first_name]
    last_name = params[:last_name]
    username = params[:username]
    telegram_id = params[:id]

    if first_name.present?
      user = User.find_or_create_by(telegram_id: telegram_id) do |user|
        user.first_name = first_name
        user.last_name = last_name
        user.username = username
      end

      session[:authorized] = true
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome, #{user.first_name}!"
    else
      session[:authorized] = false
      redirect_to root_path, notice: "Authorization failed."
    end
  end


def github
  auth_info = request.env["omniauth.auth"]

  if auth_info.nil?
    Rails.logger.error("Omniauth returned nil auth_info")
    redirect_to root_path, alert: "Authentication failed. Please try again."
    return
  end

  # Extract information with safe navigation in case some fields are missing
  github_uid = auth_info.dig('uid')
  first_name = auth_info.dig('info', 'name') || 'Unknown'
  username = auth_info.dig('info', 'nickname') || 'Unknown'
  email = auth_info.dig('info', 'email') || 'No Email Provided'

  user = User.find_or_create_by(github_uid: github_uid) do |user|
    user.first_name = first_name
    user.username = username
    user.email = email
  end

  session[:authorized] = true
  session[:user_id] = user.id

  redirect_to root_path, notice: "Welcome, #{user.first_name}!"
end

  def github_failure
    session[:authorized] = false
    redirect_to root_path, alert: "Authorization failed. Please try again."
  end
  
  def vk_success
    if params[:success]
      vk_id = params[:vk_id]
      user = User.find_or_create_by(vk_id: vk_id) do |user|
        user.first_name = params[:first_name]
        user.last_name = params[:last_name]
      end

      session[:authorized] = true
      session[:user_id] = user.id
      render json: { message: 'Session updated successfully' }, status: :ok
    else
      render json: { error: 'Authorization failed' }, status: :unprocessable_entity
    end
  end
end
