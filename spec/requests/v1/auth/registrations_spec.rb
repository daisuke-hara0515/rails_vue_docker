# 公式ドキュメントに必ず読み込むようにとあったので。
require 'rails_helper'

RSpec.describe 'POST /v1/auth/registrations' do
    it 'payloadがblankの場合、' do
        # テスト内容
        # raise ArgumentError, 'BadRequest Parameter' if payload.blank?のテスト
        # 
    end

    it '改竄されていないトークンを元に、Firebaseへjwt認証し、ユーザUIDを取得できること' do
        id_token = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFlMDVlZmMyNTM2YjJjZTdjNTExZjRiMTcyN2I4NTkyYTc5ZWJiN2UiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vaHR0cHMtdnVlanMtYmVmNjAiLCJhdWQiOiJodHRwcy12dWVqcy1iZWY2MCIsImF1dGhfdGltZSI6MTYyODQzMTAzNiwidXNlcl9pZCI6Imh0MEVhSVpiamNhbDBmRDJCSk81ZmFianlZdjEiLCJzdWIiOiJodDBFYUlaYmpjYWwwZkQyQkpPNWZhYmp5WXYxIiwiaWF0IjoxNjI4NDMxMDM2LCJleHAiOjE2Mjg0MzQ2MzYsImVtYWlsIjoiZGFpZnVrdUB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJkYWlmdWt1QHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.Y22MXTeSFR47BykFm1XhzQTBBx0A8DAsl7Yc-oOkWOeJ3qYuGLVnHysIDOMYXvTe1gKZV_DtDJytJiGuWz71mrTE6CJ6fzLVO8TdNSO2oywAaThFfq74pUzyZmitMB2c0yksRGD8HeRqAADEEve3RhNfhGO-V0ApSY68D4yyB3ZNiLfWEd9lRvwHnWFJyKmvdogcaGryumFvV5RksJfvWRnOeo4oTNvQnjPP8LJLmEmGcc5H6ysTRoJMiKQnI7x9YM6DPvP2IA6cFD904dxyK17wGAN0O8uWbCc-EKdypljPN7ibIXSuUPA8TclKDNy9XJ-PZQIzpS1OPmrYGoXRVQ"
        expect{post 'http://localhost/v1/auth/registrations', params: {idToken: id_token}}.to change{User.all.length}.by(+1)
        expect(response.status).to eq 200
    end

    it '改竄されたトークンではjwt認証でユーザUIDを取得できない' do
        # テスト書く
    end

end