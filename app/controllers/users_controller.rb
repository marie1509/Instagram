class UsersController < ApplicationController
  before_action :set_user, only: [:edit,:update]

  def new
    # form_withに渡すインスタンス変数を作成
    @user = User.new
  end

  def index

    # 全ての投稿の中から現在ログインしているユーザーの投稿を取り出す
    @pictures = Picture.where(user_id: current_user)

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

  def edit

  end

  def update

    if @user.update(user_params)
      redirect_to users_path notice: "プロフィール情報を編集しました"
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
