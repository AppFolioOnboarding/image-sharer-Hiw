class ImagesController < ApplicationController
  before_action :set_image, only: %i[show destroy]

  def index
    @all_images = Image.order(created_at: :desc)
  end

  # GET /images/:id
  def show; end

  # GET /images/new
  def new
    @image = Image.new
  end

  # POST /images
  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to @image, notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  # GET /images/:tag
  def tags
    @tag = params[:tag]
    @all_images = Image.tagged_with(@tag).order(created_at: :desc)
  end

  # DELETE /images/:id
  def destroy
    @image&.destroy
    redirect_to images_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @image = nil
  end

  # Only allow a trusted parameter "white list" through.
  def image_params
    params.require(:image).permit(:url, :tag_list, :tag)
  end
end
