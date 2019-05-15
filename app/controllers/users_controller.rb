class UsersController < ApplicationController

  before_action :check_user,{only: [:logout,:show,:edit,:update,:destroy]}
  before_action :forbid_login_user,{only: [:new,:create,:login_form,:login]}
  before_action :ensure_correct_user,{only: [:edit,:update,:destroy]}

  def ensure_correct_user
    if @current_user.id != params[:id]
      flash[:notice] = "アクセス権がありません"
      redirect_to("/")
    end
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(
      name:params[:name],
      email:params[:email],
      address:params[:address],
      password:params[:password])
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/")
    else
      render("users/new")
    end
  end

  def login_form
  end

  def login
    @user=User.find_by(email:params[:email],password:params[:password])
    if @user
      session[:user_id]=@user.id
      flash[:notice]="ログインしました"
      redirect_to("/")
    else
      @error_message="メールアドレスまたはパスワードが間違っています"
      @email=params[:email]
      @password=params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id]=nil
    flash[:notice]="ログアウトしました"
    redirect_to("/")
  end

  def show
    @user=User.find_by(id: params[:id])
    @items=Item.where(seller_id: @user.id).where(buyer_id: nil)
  end

  def edit
    @user=User.find_by(id: params[:id])
  end

  def update
    @user=User.find_by(id: params[:id])
    @user.name=params[:name]
    @user.email=params[:email]
    @user.address=params[:address]
    @user.password=params[:password]
    if @user.save
      flash[:notice]="ユーザーの編集を完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def destroy
    @user=User.find_by(id: params[:id])
    @items=Item.where(seller_id: @user.id)
    @items.destroy
    session[:user_id]=nil
    @user.destroy
    flash[:notice]="アカウントを削除しました"
    redirect_to("/")
  end

end
