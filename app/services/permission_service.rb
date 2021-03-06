class PermissionService
  attr_reader :user,
    :controller,
    :action

  def initialize(user)
    @user = user || User.new

  end

  def allow?(controller, action)
    @controller = controller
    @action = action

    if user.store_admin?
      store_admin_permissions
    elsif user.registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end


  private

#The store admin will have access to the stores, sessions, items, and orders controllers.
#However, he won’t have access to the users controller.
  #
  def store_admin_permissions
    return true if controller == 'stores' && action.in?(%w(index show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'items' && action.in?(%w(index show new create destroy))
    return true if controller == 'orders' && action.in?(%w(index show new create destroy))
  end

  def registered_user_permissions
    return true if controller == 'stores' && action.in?(%w(index show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
  end

  def guest_user_permissions
    return true if controller == 'stores' && action == 'index'
    return true if controller == 'sessions' && action.in?(%w(new create))
  end

end

