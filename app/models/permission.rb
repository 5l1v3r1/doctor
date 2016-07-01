class Permission < Struct.new(:user)
  def allow?(controller, action)
    return true if controller == "sessions"
    return true if controller == "hub" && action.in?(%w[index])
    return true if controller == "users" && action != "index"
    return true if controller == "categories" && action.in?(%w[index show])
    return true if controller == "documents" && action.in?(%w[index show])
  
    if user
      return true if controller == "categories" && action.in?(%w[index show edit new create])
      return true if controller == "documents" && action.in?(%w[index show edit new create])
      return true if user.admin?
    end
    false
  end
end