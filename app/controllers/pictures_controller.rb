class PicturesController < ApplicationController
  before_action :set_picture, only: [:show,:edit,:update,:destroy]
  before_action :force_login, only: [:new,:edit,:index]

  def index
    # 一覧画面に表示させるために全てのレコードを取得

    @pictures = Picture.all

  end

  def show
    # 詳細画面でfavoriteするかしないかを渡すインスタンス

    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    # 投稿画面のformに渡すためのインスタンス変数
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create

    @picture = Picture.new(picture_params)
    # userとpictureテーブルが結びついているので、user_idを取得しなければエラーとなってしまうので下記の記述いる
    @picture.user_id = current_user.id
    @picture.image.retrieve_from_cache! params[:cache][:image] if params[:cache][:image].present?

   if @picture.save!
     PictureMailer.picture_mail(@picture).deliver
     redirect_to pictures_path
   else
    render 'new'
   end

  end

  def edit
    # まず編集したいコンテンツのidを取得する必要がある
  end

  def update

    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "Content has been succesfully edited"
    else
      render 'edit'
    end
  end

  def destroy
    @picture.destroy
      redirect_to pictures_path, notice: "Content has been succesfully deleted"
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id

    render :new if @picture.invalid?

  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end


  def picture_params
    params.require(:picture).permit(:content,:image)
  end

  def force_login
    if !logged_in?
      redirect_to new_session_path , notice: "ログインしてください"
    end
  end
end
