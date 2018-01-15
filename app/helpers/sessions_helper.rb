module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
      #!はfalseを返す current_userは中に何か入っているか？という意味
    !current_user.nil?  
  end
end
