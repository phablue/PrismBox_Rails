module OrdersHelper
  def current_user_full_name
    "#{current_user.first_name.titlecase} #{current_user.last_name.titlecase}"
  end
end
