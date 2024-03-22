require 'fastimage'

class GalleryImagesController < ApplicationController
  before_action :set_gallery_image, only: %i[ show edit update lower higher destroy ]
  before_action :set_gallery, only: %i[ lower higher destroy ]

  def create
    @gallery = Gallery.find(params[:gallery_id])

    if @gallery.gallery_images.any?
      position = @gallery.gallery_images.max_by { |gallery_image| gallery_image.position }.position + 1
    else
      position = 1
    end

    # book image orientation

    file_size = FastImage.size(gallery_image_params[:image])
    orientation = 'landscape'

    if file_size[0] == file_size[1]
      orientation = 'square'
    elsif file_size[0] < file_size[1]
      orientation = 'portrait'
    end

    # 

    @gallery_image = @gallery.gallery_images.new(gallery_image_params)
    @gallery_image.position = position
    @gallery_image.orientation = orientation

    respond_to do |format|
      if @gallery_image.save
        format.turbo_stream
    #     format.html { redirect_to gallery_image_url(@gallery_image), notice: "Gallery image was successfully created." }
    #     format.json { render :show, status: :created, location: @gallery_image }
      else
        format.turbo_stream
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @gallery_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def higher
    @gallery_image.move_higher
    @gallery_images = @gallery.gallery_images

    respond_to do |format|
      format.turbo_stream { render 'move' }
    end
  end

  def lower
    @gallery_image.move_lower
    @gallery_images = @gallery.gallery_images

    respond_to do |format|
      format.turbo_stream { render 'move' }
    end
  end

  def destroy
    @gallery_image.remove_from_list
    @gallery_image.destroy

    # respond_to do |format|
    #   format.html { redirect_to gallery_images_url, notice: "Gallery image was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    def set_gallery_image
      @gallery_image = GalleryImage.find(params[:id])
    end

    def set_gallery
      @gallery = @gallery_image.gallery
    end

    def gallery_image_params
      params.require(:gallery_image).permit(:gallery_id, :image, :position)
    end
end
