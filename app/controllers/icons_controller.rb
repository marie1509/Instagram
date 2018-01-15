class IconsController < ApplicationController
  def new
    @user_id = current_user.id
    @icon = Icon.new
  end

  def create

    @icon = Icon.new(params_icon)
    @icon.user_id = current_user.id

    @icon.save
     redirect_to users_path
  end

  def params_icon
    params.require(:icon).permit(:image)
  end
end
