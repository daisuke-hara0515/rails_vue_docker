class User < ActiveRecord::Base
  # UserとTaskの関連付け、オプションでUserが削除された時に関連づけられたオブジェクトのdestoryメソッドが実行される
  has_many :tasks, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
end
