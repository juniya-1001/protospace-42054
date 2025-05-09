class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :update, :destroy, :edit]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_index, only: :edit

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
    redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    # @prototype = Prototype.find(params[:id])
  end

  def update
    # @prototype = Prototype.find(params[:id])
      if @prototype.update(prototype_params)
        redirect_to '/'
      else
        render :edit, status: :unprocessable_entity
      end
  end


  def destroy
    # @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy, :concept, :user, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless @prototype.user.id == current_user.id
      redirect_to action: :index
    end
  end
end