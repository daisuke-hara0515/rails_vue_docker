# 公式ドキュメントに必ず読み込むようにとあったので。
require 'rails_helper'

RSpec.describe 'POST /v1/auth/registrations' do
    it 'payloadがblankの場合、' do
        # テスト内容
        # raise ArgumentError, 'BadRequest Parameter' if payload.blank?のテスト
        # 
    end

    it '改竄されていないトークンを元に、Firebaseへjwt認証し、ユーザUIDを取得できること' do
        # id_token = ""
        # expect{post 'http://localhost/v1/auth/registrations', params: {idToken: id_token}}.to change{User.all.length}.by(+1)
        # expect(response.status).to eq 200
    end

    it '改竄されたトークンではjwt認証でユーザUIDを取得できない' do
        # テスト書く
    end

end