﻿class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
  @users = User.all
  end
  
  def show
    @users = User.paginate(page: params[:page])
  end

  def new
  @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Bem vindo ao Twitter Teste!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
def edit
  end
	
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Perfil alterado com sucesso!"
      sign_in @user
      redirect_to @user
	else
		render 'edit'
	end	
  end 
  
  def destroy
	User.find(params[:id]).destroy
	flash[:success] = "User destroyed"
	redirect_to users_url
  end
  
  private
  
	def signed_in_user
      unless signed_in?
        store_location
        redirect_to login_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end