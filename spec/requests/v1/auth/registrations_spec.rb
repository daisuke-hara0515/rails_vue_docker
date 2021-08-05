# 公式ドキュメントに必ず読み込むようにとあったので。
require 'rails_helper'

RSpec.describe 'POST /v1/auth/registrations' do
    it '改竄されていないトークンを元に、Firebaseへjwt認証しユーザUIDを取得できること' do
        # テスト書く    
    end

    it '改竄されたトークンではjwt認証でユーザUIDを取得できない' do
        # テスト書く
    end

end