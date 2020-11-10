class PrototypesController < ApplicationController
  before_action :authenticate_user!, only:[:index,:show,:edit,:destroy,:update]


  def index
    @prototypes= Prototype.all
  end
  
  def new
    @prototype = Prototype.new
  end

  def create
    @prototype= current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to root_path(@user)
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user.id
      redirect_to action: :index
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    if prototype.save
      redirect_to @prototype = Prototype.find(params[:id])
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
