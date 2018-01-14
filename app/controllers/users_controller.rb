class UsersController < ApplicationController
  def new
    # form_withに渡すインスタンス変数を作成
    @user = User.new
  end

  def create
    # パラメーターで値を取得して、オブジェクト作成
    @user = User.new(user_params)

    # pictures コントローラーの一覧画面へリダイレクトさせる
    if @user.save
      redirect_to pictures_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
