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

end
