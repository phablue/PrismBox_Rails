module OrdersHelper
  def full_name_of user
    "#{user.first_name.titlecase} #{user.last_name.titlecase}"
  end

  def consumer_user order
    if order.id.nil?
      current_user
    else
      User.find(order.user_id)
    end
  end
end
