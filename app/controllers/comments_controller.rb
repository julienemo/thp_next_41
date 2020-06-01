class CommentsController < ApplicationController
  before_action :private_route
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_image
  before_action :can_change_or_delete, only: [:edit, :update, :destroy]

  include CommentsHelper

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    puts @image.id
    puts @user.username
    @comment = Comment.new(comment_params.merge(image: @image).merge(user: @user))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to image_path(@image), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to image_path(@image) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params.merge(image: @image).merge(user: @user))
        format.html { redirect_to image_path(@image), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { redirect_to image_path(@image) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
        format.html { redirect_to image_path(@image), notice: 'Comment was successfully deletetd.' }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    puts "3"*50
    puts params
    puts "4"*50
    puts params.require(:comment).permit(:content)
    return params.require(:comment).permit(:content)
  end

  def set_image
    @image = Image.find(params[:image_id])
  end

  def can_change_or_delete
    unless current_user == @comment.user
      flash[:notice] = "You're not allowed for this action."
      redirect_to image_path(@image)
    end
  end
end
