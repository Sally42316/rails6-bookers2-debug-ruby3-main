class ApplicationMailer < ActionMailer::Base
  # 全メーラー共通の設定。デフォルトのままでOK
  default from: 'from@example.com'
  layout 'mailer'
end
