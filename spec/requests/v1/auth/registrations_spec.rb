# 公式ドキュメントに必ず読み込むようにとあったので。
require 'rails_helper'

RSpec.describe 'POST /v1/auth/registrations' do
    it 'idTokenが正しくない場合、FirebaseIdToken.verify tokenの結果がnilになること' do
        # テスト内容
        # payload = nilでいいのか？
        # 
    end

    it '改竄されていないトークンを元に、Firebaseへjwt認証し、ユーザUIDを取得できること' do
        # テスト書く
    end

    it '改竄されたトークンではjwt認証でユーザUIDを取得できない' do
        # テスト書く
    end

end