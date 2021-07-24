class V1::Auth::RegistrationsController < DeviceTokenAuth::RegistrationsController
    # 定義したbefore_actionを使いたくない時はskip_before_action
    skip_before_action :authenticate_user

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

    # ぼっち演算子を使ってリクエストヘッダーのAuthorizationがあればsplit以下を実行
    def token_from_request_headers
        request.headers['Authorization']&.split&.last
    end

    def token
        # ||はor演算子なのでparamsかtoken_from~のどちらかを返す
        params[:token] || token_from_request_headers
    end

end
