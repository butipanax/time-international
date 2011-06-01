#encoding: utf-8
class Notifier < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_created.subject
  #
  def order_created(order)
    @order = order
    mail :to => User.find_by_id(@order.user_id).email, :subject => "来自Time international GmbH的购物确认信件"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order = order
    mail :to => User.find_by_id(@order.user_id).email, :subject => "来自Time international GmbH的包裹发送信息"
  end
end
