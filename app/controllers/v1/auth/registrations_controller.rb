class V1::Auth::RegistrationsController < DeviceTokenAuth::RegistrationsController
    # 定義したbefore_actionを使いたくない時はskip_before_action
    skip_before_action :authenticate_user

    def create
        # Googleのx509証明書をダウンロードする
        FirebaseIdToken::Certificates.request
        # ペイロードが空白だった場合、意図的にエラー(ArgumentError)を発生させる
        raise ArgumentError, 'BadRequest Parameter' if payload.blank?

end
