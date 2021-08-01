class User < ActiveRecord::Base
  # UserとTaskの関連付け、オプションでUserが削除された時に関連づけられたオブジェクトのdestoryメソッドが実行される
  has_many :tasks, dependent: :destroy
end
