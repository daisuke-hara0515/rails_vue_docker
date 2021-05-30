# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # 認証トークンが有効かどうかを確認する
  client = request.headers['client']
  token = request.headers['access-token']

  @resource.valid_token?(token,client)
end
