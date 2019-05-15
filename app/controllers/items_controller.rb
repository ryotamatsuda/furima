class ItemsController < ApplicationController

  before_action :check_user
  before_action :ensure_correct_user,{only: [:edit,:update,:destroy]}

  def ensure_correct_user
    @item=Item.find_by(id: params[:id])
    if @item.seller_id != @current_user.id
      flash[:notice]="権限がありません"
      redirect_to("/")
    end
  end

  def index
    @items=Item.all.order(created_at: :desc)
  end

  def on_sale
    @items=Item.where(buyer_id: nil).order(created_at: :desc)
  end

  def new
    @item=Item.new
  end

  def create
    @item=Item.new(
      name:params[:name],
      price:params[:price],
      condition:params[:condition],
      seller_id:@current_user.id)
    if @item.save
      if params[:image]
        @item.image_name="#{@item.id}.jpg"
        @image=params[:image]
        File.binwrite("public/item_images/#{@item.image_name}",@image.read)
        @item.save
      end
      flash[:notice]="出品が完了しました"
      redirect_to("/items/index")
    else
      render("items/new")
    end
  end

  def show
    @item=Item.find_by(id:params[:id])
  end

  def edit
    @item=Item.find_by(id: params[:id])
  end

  def update
    @item=Item.find_by(id: params[:id])
    @item.name=params[:name]
    @item.price=params[:price]
    @item.condition=params[:condition]
    #もし画像があれば
    if params[:image]
      #すでに画像あり
      if @item.image_name
        File.delete("public/item_images/#{@item.image_name}")
        @image=params[:image]
        File.binwrite("public/item_images/#{@item.image_name}",@image.read)
      #まだ画像なし
      else
        @item.image_name="#{@item.id}.jpg"
        @image=params[:image]
        File.binwrite("public/item_images/#{@item.image_name}",@image.read)
      end
    end
    if @item.save
      flash[:notice]="ユーザーの編集を完了しました"
      redirect_to("/items/index")
    else
      render("items/edit")
    end
  end

  def destroy
    @item=Item.find_by(id: params[:id])
    @item.destroy
    flash[:notice]="商品を削除しました"
    redirect_to("/")
  end

  def buy_form
    @item=Item.find_by(id: params[:id])
  end

  def buy
    @item=Item.find_by(id: params[:id])
    @item.buyer_id=@current_user.id
    @item.save
    flash[:notice]="購入が完了しました"
    redirect_to("/items/index")
  end

  def am_selling
    @items=Item.where(seller_id: @current_user.id).where(buyer_id: nil)
  end

  def sold
    @items=Item.where(seller_id: @current_user.id)
  end

  def bought
    @items=Item.where(buyer_id: @current_user.id)
  end

end
