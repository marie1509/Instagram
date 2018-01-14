class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)
    # authenticateメソッドは引数にパスワードを渡すことで、認証の成否を判定する
    if user &&  user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      # sessionコントローラーからもUserモデルにアクセスすることができる（紐づいていないコントローラーとモデル）
      redirect_to user_path(user.id)
    else
      flash[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

 def destroy
   session.delete(:user_id)
  flash[:notice] = 'ログアウトしました'
  redirect_to new_session_path

 end

end
