module NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @rate = nil
    @recipe = Cocktail.find_by(id: notification.cocktail_id)
    @visiter_rate = notification.rate_id
    @visiter_dm = notification.direct_message_id 
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href:public_end_user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.name, href:public_end_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたのレシピ', href:public_cocktail_path(notification.cocktail_id), style:"font-weight: bold;")+"(#{@recipe.name})"+"にいいねしました"
      when "rate" then
        @rate = Rate.find_by(id: @visiter_rate)&.comment
        tag.a(@visiter.name, href:public_end_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたのレシピ', href:public_cocktail_path(notification.cocktail_id), style:"font-weight: bold;")+"(#{@recipe.name})"+"にコメントしました"
      when "dm" then
        tag.a(notification.visiter.name, href:public_end_user_path(@visiter), style:"font-weight: bold;")+"から"+tag.a('メッセージ', href:rooms_path, style:"font-weight: bold;")+"が届きました"
    end
  end

  def unchecked_notifications
    @notifications = current_end_user.passive_notifications.where(checked: false)
  end

end
