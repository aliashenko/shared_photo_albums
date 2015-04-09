class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all.order(:name).page(params[:page]).per(10)
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
