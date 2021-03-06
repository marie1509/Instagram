class FavoritesController < ApplicationController
  def index
    # まず現在current_userのidを取得する
    # その人が沖にいるしているpictureを取得する
    @favorites = current_user.favorites

  end


  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    redirect_to pictures_path
  end

  def destroy
    favorite = current_user.favorites.find_by(picture_id: params[:id]).destroy
    redirect_to pictures_path
  end
end
