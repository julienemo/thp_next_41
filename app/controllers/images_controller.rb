class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :private_route, except: [:index]
  before_action :define_current_user, except: [:index]
  before_action :can_change_or_delete, only: [:edit, :update, :destroy]
  
  include ImagesHelper
  def index
    @images = Image.all
  end

  def show
    @current_user_can_see_image = current_user_can_see_image(@image)
  end

  def new
    @image = Image.new
  end

  def edit
  end

  def create
    permit_image_params
    @image = Image.new(
      uploaded_by: @user,
      description: @description,
      stream: Base64.strict_encode64(File.open(@image_stream.tempfile).read),
      extension: @extension,
      is_private: @is_private
    )

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    permit_image_params

    respond_to do |format|
      if @image.update(
      uploaded_by: @user,
      description: @description,
      stream: Base64.strict_encode64(File.open(@image_stream.tempfile).read),
      extension: @extension,
      is_private: @is_private
      )
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_image
      @image = Image.find(params[:id])
    end

    def permit_image_params
      @image_stream = params.require(:image).permit(:stream)[:stream]
      @extension = @image_stream.original_filename.split(".")[-1]
      @description = params.require(:image).permit(:description)[:description]
      @is_private = params.require(:image).permit(:is_private)[:is_private]
    end

    def define_current_user
      @user = current_user
    end

    def can_change_or_delete
      unless current_user == @image.uploaded_by
        flash[:notice] = "You're not allowed for this action."
        redirect_to image_path(@image)
      end
    end
end
