# 参照コードhttps://github.com/penguinwokrs/firebase-auth-rails#example-code
module V1
    module Auth
        class V1::Auth::RegistrationsController < ApplicationController
    # 定義したbefore_actionを使いたくない時はskip_before_action
            skip_before_action :authenticate_user
            
            class << self
                def verifier
                    @verifier ||= FirebaseVerifier.new
                end

                def verifier=(verifier)
                    @verifier = verifier
                end
            end

            def payload
                @payload ||= self.class.verifier.verify token
            end

            def create
                # Googleのx509証明書をダウンロードする
                FirebaseIdToken::Certificates.request
                # ペイロードが空白だった場合、意図的にエラー(ArgumentError)を発生させる
                raise ArgumentError, 'BadRequest Parameter' if payload.blank?
                # 認証OKの時、レスポンスのペイロードにあるsubの中身を条件にユーザーを検索。
                # 条件が合うユーザーがいない場合は新規作成
                @user = User.find_or_initialize_by(uid: payload['sub'])
                if @user.save
                    render json: @user, status: :ok
                else
                    render json: @user.errors, status: :unprocessable_entity
                end
            end

            private

            def sign_up_params
                params.require(:registration).permit(:user_name, :display_name, :idToken)
            end

            # ぼっち演算子を使ってリクエストヘッダーのAuthorizationがあればsplit以下を実行
            def token_from_request_headers
                request.headers['Authorization']&.split&.last
            end

            def token
                # ||はor演算子なのでparamsかtoken_from~のどちらかを返す
                params[:idToken] || token_from_request_headers
            end

            # payloadがfalseか未定義なら、@payloadにFirebaseIdToken〜を代入する
            # tokenが改竄されていると、nilを返すのでpayload.blank?でtrueになる
            # def payload
            #     @payload ||= FirebaseIdToken::Signature.verify token
            # end
        end

        # Firebase関連をまとめたクラス
        class FirebaseVerifier
            def verify(token)
                FirebaseIdToken::Certificates.request
                FirebaseIdToken::Signature.verify token
            end
        end
    end
end
