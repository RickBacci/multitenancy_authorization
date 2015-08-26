module ApplicationHelper
  # helpers are for display purposes
  def registered_user?
    current_user && current_user.registered_user?
  end

end
